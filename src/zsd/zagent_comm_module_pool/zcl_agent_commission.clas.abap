CLASS zcl_agent_commission DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES : BEGIN OF ty,
              agentcode    TYPE C LENGTH 10,
              InvoiceNo    TYPE C LENGTH 10,
              totalamount  TYPE  menge_d,
            END OF ty.
    CLASS-DATA it TYPE TABLE OF ty .
     TYPES : BEGIN OF ty1,
              SelectedTableData LIKE it,
            END OF ty1.
   CLASS-DATA RESPO TYPE ty1 .
    CLASS-DATA:
      lv_cid     TYPE abp_behv_cid,
      i_responce TYPE TABLE OF string.

    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AGENT_COMMISSION IMPLEMENTATION.


  METHOD if_http_service_extension~handle_request.


    DATA(req) = request->get_form_fields(  ).
    DATA(body)  = request->get_text(  )  .

   DATA(return)  = VALUE #( req[ name = 'return' ]-value OPTIONAL ) .

    xco_cp_json=>data->from_string( body )->write_to( REF #( RESPO ) ).



    DATA: lt_je_deep TYPE TABLE FOR ACTION IMPORT i_journalentrytp~post,
          lt_je_val  TYPE TABLE FOR FUNCTION IMPORT  i_journalentrytp~validate,
          wa_je_deep LIKE LINE OF lt_je_deep,
          lv_cid1    TYPE abp_behv_cid,
          lv_cid     TYPE abp_behv_cid.


    DATA :ar_item   LIKE wa_je_deep-%param-_apitems[],
          _taxitems LIKE wa_je_deep-%param-_taxitems[],
          gl_item   LIKE wa_je_deep-%param-_glitems[].


    DATA: responce TYPE string.

    TRY.
        lv_cid1 = to_upper( cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ) ).
      CATCH cx_uuid_error.
        ASSERT 1 = 0.
    ENDTRY.

  SELECT   a~agentcode , SUM( a~totalamount ) as totalamount
  FROM @RESPO-selectedtabledata   as a GROUP BY agentcode
  INTO TABLE @DATA(tabl1)  .

 LOOP AT tabl1 INTO DATA(WA).

 DATA suplier TYPE n LENGTH 10.
 DATA Taxcode TYPE c LENGTH 2.
  DATA SGST TYPE P DECIMALS 2.
  DATA CGST TYPE P DECIMALS 2.
  DATA IGST TYPE P DECIMALS 2.
  DATA journalentryitemamount TYPE P DECIMALS 2.

   suplier =  wa-agentcode.
   SELECT SINGLE * FROM I_Supplier WITH PRIVILEGED ACCESS WHERE Supplier = @suplier INTO @data(region).


   if region-Region = '08'.

   Taxcode  = 'P3' .
   SGST = WA-totalamount * 9 / 100.
   CGST = WA-totalamount * 9 / 100.
   journalentryitemamount = WA-totalamount + SGST + CGST .
   ELSE.

   Taxcode  = 'PC' .
   IGST = WA-totalamount * 18 / 100.
   journalentryitemamount =  WA-totalamount + IGST  .
   ENDIF.

   if return = 'Return' .

   WA-totalamount   =  WA-totalamount * -1.
   cgst = cgst * -1.
   Sgst = Sgst * -1.
   igst = igst * -1.
   else.
   journalentryitemamount  =  journalentryitemamount * -1 .
   ENDIF.

    wa_je_deep-%cid = lv_cid1.
    wa_je_deep-%param = VALUE #(
    companycode              = '1000' " Success
    accountingdocumenttype   = 'KA' " 'SA'
    documentdate             = sy-datum
    createdbyuser            = sy-uname
    postingdate              = sy-datum
    taxdeterminationdate     = sy-datum
    ).

    ar_item =  VALUE #( (
                            glaccountlineitem   = '010'
                            supplier            = wa-agentcode
                            documentitemtext    = 'SC-AGENCY'
                            businessplace       = '1010'
                            _currencyamount     = VALUE #( ( currencyrole           = '00'
                                                             journalentryitemamount =  journalentryitemamount
                                                             currency               = 'INR' ) ) ) ).
    APPEND LINES OF ar_item  TO wa_je_deep-%param-_apitems.

    gl_item  = VALUE #( ( glaccountlineitem = '020'
    taxitemacctgdocitemref = '010'
         glaccount          = '4450001001'
         costcenter         = '1100001103'
         businessplace      = '1010'
         taxcode            = taxcode
         valuedate          = sy-datum
     _currencyamount = VALUE #( ( currencyrole = '00' journalentryitemamount = WA-totalamount currency = 'INR' ) ) ) ).
    APPEND LINES OF gl_item TO wa_je_deep-%param-_glitems.

IF cgst <> 0 .
    _taxitems  = VALUE #( ( glaccountlineitem = '030'
        taxitemacctgdocitemref = '020'
        taxcode          = taxcode
        conditiontype    =  'JICG'
        isdirecttaxposting = 'X'
        taxdeterminationdate    = sy-datum
        _currencyamount = VALUE #( ( currencyrole = '00' journalentryitemamount = cgst taxbaseamount = WA-totalamount currency = 'INR' ) ) ) ).
    APPEND LINES OF _taxitems TO wa_je_deep-%param-_taxitems.

   _taxitems  = VALUE #( ( glaccountlineitem = '040'
       taxitemacctgdocitemref = '020'
       taxcode          = 'P3'
       conditiontype    =  'JISG'
       isdirecttaxposting = 'X'
       taxdeterminationdate    = sy-datum
       _currencyamount = VALUE #( ( currencyrole = '00' journalentryitemamount = Sgst taxbaseamount = WA-totalamount currency = 'INR' ) ) ) ).
    APPEND LINES OF _taxitems TO wa_je_deep-%param-_taxitems.

ELSEIF igst <> 0 .

  _taxitems  = VALUE #( ( glaccountlineitem = '030'
       taxitemacctgdocitemref = '020'
       taxcode          = 'PC'
       conditiontype    =  'JIIG'
       isdirecttaxposting = 'X'
       taxdeterminationdate    = sy-datum
       _currencyamount = VALUE #( ( currencyrole = '00' journalentryitemamount = igst taxbaseamount = WA-totalamount currency = 'INR' ) ) ) ).
    APPEND LINES OF _taxitems TO wa_je_deep-%param-_taxitems.

ENDIF.

    APPEND wa_je_deep TO lt_je_deep.
    CLEAR:wa_je_deep,gl_item.

    MODIFY ENTITIES OF i_journalentrytp
    ENTITY journalentry
    EXECUTE post FROM lt_je_deep
    FAILED DATA(ls_failed_deep1)
    REPORTED DATA(ls_reported_deep1)
    MAPPED DATA(ls_mapped_deep1).

    IF ls_failed_deep1 IS NOT INITIAL.
      LOOP AT ls_reported_deep1-journalentry ASSIGNING FIELD-SYMBOL(<ls_reported_deep1>).
*DATA(lv_result) = ls_reported_deep-%msg->if_message~get_text( ).
        IF sy-tabix <> 1.
          IF <ls_reported_deep1>-%msg->if_t100_dyn_msg~msgty = 'E'.
            DATA(lv_result1) = <ls_reported_deep1>-%msg->if_message~get_longtext( ).
            CONCATENATE 'Error :-' lv_result1 INTO responce .
            APPEND responce TO i_responce.
            CLEAR responce.
          ENDIF.
        ENDIF.

      ENDLOOP.
    ELSE.

      COMMIT ENTITIES BEGIN
      RESPONSE OF i_journalentrytp
      FAILED DATA(lt_commit_failed)
      REPORTED DATA(lt_commit_reported).
      COMMIT ENTITIES END.
   DATA acc_do_no TYPE STRING.
        LOOP AT lt_commit_reported-journalentry INTO DATA(w).
          IF w-%msg->if_t100_dyn_msg~msgty = 'S'.
            responce  = |Document :-{ w-%msg->if_t100_dyn_msg~msgv2+0(10) } Generated|.
            acc_do_no = w-%msg->if_t100_dyn_msg~msgv2+0(10) .
            APPEND responce TO i_responce.
            CLEAR responce.
          ENDIF.
        ENDLOOP.

 LOOP AT respo-selectedtabledata INTO DATA(WA1) .
  DATA invoiceno TYPE C LENGTH 10 .
  invoiceno =  |{ WA1-invoiceno ALPHA = IN }| .
  UPDATE zagent_tab SET vandor_inv  = @acc_do_no , fiscalyear = @SY-datum+0(4) , companycode = '1000'
  WHERE  agentcode = @WA1-agentcode AND  invoicenumber = @invoiceno.

 ENDLOOP.
    ENDIF.

    FREE: lt_je_deep[].
    CLEAR:region,suplier,sgst,cgst,taxcode,invoiceno.

  ENDLOOP.


DATA:json TYPE REF TO if_xco_cp_json_data.
 xco_cp_json=>data->from_abap(
      EXPORTING
        ia_abap      = i_responce
      RECEIVING
        ro_json_data = json ).
    json->to_string(
      RECEIVING
        rv_string = responce ).

    response->set_text( responce ).
  ENDMETHOD.
ENDCLASS.
