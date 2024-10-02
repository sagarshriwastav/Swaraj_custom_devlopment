class ZCL_BANKSERVICENEW definition
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:BEGIN OF ty_json,

            clientcode     TYPE string,
            refnumber      TYPE string,
            virtualaccountnumber TYPE STRING ,
            trandate           TYPE string,
            tranamount         TYPE string,
            paymentmode        TYPE string,
            remitteraccnumber  TYPE string,
            remitteraccname    TYPE string,
            remitterifsc       TYPE string,
            journalentryno       TYPE string,
            error              TYPE string,
          END OF ty_json.

DATA fLAG TYPE c .
DATA   ID1      TYPE STRING VALUE  'FI_BANK_CO_U'  .
DATA   PASSWORD1  TYPE STRING VALUE  'Zd<ilvKf2yrJUeCErwkAaWSbQHmLUsxsKrYtmEBN'  .

    DATA:it_json TYPE TABLE OF ty_json.
    DATA : wa_json TYPE ty_json .

    DATA : it_pay TYPE TABLE OF   zbank_data1,
           wa_pay LIKE LINE OF it_pay.
    DATA : createdate TYPE datum.
    DATA : year TYPE string.
    DATA : month TYPE string.
    DATA : day TYPE string.



    DATA:lt_je_deep TYPE TABLE FOR ACTION IMPORT i_journalentrytp~post,
         wa_je_deep LIKE LINE OF lt_je_deep.

    DATA :ar_item LIKE wa_je_deep-%param-_aritems[],
          gl_item LIKE wa_je_deep-%param-_glitems[].

    CLASS-DATA:
      lv_cid     TYPE abp_behv_cid,
      i_responce TYPE TABLE OF string.

*    INTERFACES if_oo_adt_classrun.
    INTERFACES if_http_service_extension .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_BANKSERVICENEW IMPLEMENTATION.


 METHOD if_http_service_extension~handle_request.
*  METHOD if_oo_adt_classrun~main.

 DATA:json TYPE REF TO if_xco_cp_json_data.
          TYPES:BEGIN OF ty_generic ,
              transactionid TYPE string,
              code          TYPE string,
              status        TYPE string,
              trandate      TYPE string,
              refnumber     TYPE string,
            END OF ty_generic.
 DATA:generic TYPE ty_generic.
 DATA:res TYPE ty_generic.
 DATA:responce TYPE string.
 CLEAR:responce.

    DATA(req) = request->get_header_fields(  ).
    DATA(body)  = request->get_text(  )  .
    REPLACE ALL OCCURRENCES OF '\n'  IN body WITH ''.
   xco_cp_json=>data->from_string( body )->write_to( REF #( wa_json ) ).



*VALIDATION 1
data(ID)  = VALUE #( req[ name = 'username' ]-value OPTIONAL ) .
data(Password)  = VALUE #( req[ name = 'password' ]-value OPTIONAL ) .


IF password <> PASSWORD1 .
fLAG  = 'X'  .

      res-transactionid = ''.
      res-code = '001'.
      res-status = 'WRONG PASSWORD PASSWORD'.
      res-trandate = wa_json-trandate.
      res-refnumber = wa_json-refnumber.

    xco_cp_json=>data->from_abap(
      EXPORTING
        ia_abap      = res "i_responce
      RECEIVING
        ro_json_data = json ).
    json->to_string(
      RECEIVING
        rv_string = responce ).

    REPLACE ALL OCCURRENCES OF 'CODE'  IN responce WITH 'code'.
    REPLACE ALL OCCURRENCES OF 'STATUS'  IN responce WITH 'status'.
    REPLACE ALL OCCURRENCES OF 'TRANSACTIONID'  IN responce WITH 'transactionid'.
    REPLACE ALL OCCURRENCES OF 'TRANDATE'  IN responce WITH 'trandate'.
    REPLACE ALL OCCURRENCES OF 'REFNUMBER'  IN responce WITH 'refnumber'.
    response->set_text( responce ).
 ENDIF .


*VALIDATION  2  CHECK REFRENCE NUMBER
SELECT  SINGLE * FROM zbank_data1
  WHERE refnumber = @wa_json-refnumber and error = '' INTO @DATA(LV1)  .
IF SY-SUBRC = 0  AND fLAG IS INITIAL .
fLAG  = 'X'  .

      res-transactionid = ' '.
      res-code          = '003'.
      res-status        = 'Refrence  Number  Already Exist'.
      res-trandate      = wa_json-trandate.
      res-refnumber = wa_json-refnumber.
     MODIFY zbank_data1 FROM  @wa_pay .
    xco_cp_json=>data->from_abap(
      EXPORTING
        ia_abap      = res "i_responce
      RECEIVING
        ro_json_data = json ).
    json->to_string(
      RECEIVING
        rv_string = responce ).

    REPLACE ALL OCCURRENCES OF 'CODE'  IN responce WITH 'code'.
    REPLACE ALL OCCURRENCES OF 'STATUS'  IN responce WITH 'status'.
    REPLACE ALL OCCURRENCES OF 'TRANSACTIONID'  IN responce WITH 'transactionid'.
    REPLACE ALL OCCURRENCES OF 'TRANDATE'  IN responce WITH 'trandate'.
    REPLACE ALL OCCURRENCES OF 'REFNUMBER'  IN responce WITH 'refnumber'.
    response->set_text( responce ).

ENDIF .



* VALIDATION 3 VAN
  SELECT SINGLE businesspartner FROM i_businesspartnerbank WITH PRIVILEGED ACCESS WHERE  bankaccount = @wa_json-virtualaccountnumber
      INTO @DATA(businesspartner).
IF SY-subrc <> 0 AND FLAG IS INITIAL .

DATA RES1 TYPE STRING.
fLAG  = 'X'  .

      res-transactionid = ' '.
      res-code = '002'.
      res-status = 'VAN not available'.
      res-trandate = wa_json-trandate.
      res-refnumber = wa_json-refnumber.

    xco_cp_json=>data->from_abap(
      EXPORTING
        ia_abap      = res "i_responce
      RECEIVING
        ro_json_data = json ).
    json->to_string(
      RECEIVING
        rv_string = responce ).

    REPLACE ALL OCCURRENCES OF 'CODE'  IN responce WITH 'code'.
    REPLACE ALL OCCURRENCES OF 'STATUS'  IN responce WITH 'status'.
    REPLACE ALL OCCURRENCES OF 'TRANSACTIONID'  IN responce WITH 'transactionid'.
    REPLACE ALL OCCURRENCES OF 'TRANDATE'  IN responce WITH 'trandate'.
    REPLACE ALL OCCURRENCES OF 'REFNUMBER'  IN responce WITH 'refnumber'.
    response->set_text( responce ).
ENDIF.

IF flag is INITIAL  .

    TRY.
        lv_cid = to_upper( cl_uuid_factory=>create_system_uuid( )->create_uuid_x16( ) ).
      CATCH cx_uuid_error.
        ASSERT 1 = 0.
    ENDTRY.

    MOVE-CORRESPONDING wa_json TO wa_pay.
  wa_pay-trandate =  wa_json-trandate+0(4) && wa_json-trandate+5(2) && wa_json-trandate+8(2) .

    SELECT SINGLE * FROM i_journalentrytp WITH PRIVILEGED ACCESS WHERE accountingdocumentheadertext = @wa_pay-refnumber  AND documentdate = @wa_pay-trandate INTO @DATA(it_alredy).

    IF it_alredy IS INITIAL.

      wa_je_deep-%cid   = lv_cid.
      wa_je_deep-%param = VALUE #( companycode                  = '1000'
                                   documentreferenceid          = wa_pay-refnumber
                                   createdbyuser                = 'Union Bank india'
                                   businesstransactiontype      = 'RFBU'
                                   accountingdocumenttype       = 'DZ'
                                   documentdate                 = wa_pay-trandate "wa_pay-creditdatetime
                                   postingdate                  = wa_pay-trandate "wa_pay-creditdatetime
                                   accountingdocumentheadertext = wa_pay-refnumber
                                   jrnlentrycntryspecificref2   = wa_pay-refnumber


                                 ).

      SELECT SINGLE b~housebank
             FROM i_bank_2 WITH PRIVILEGED ACCESS AS a
             INNER JOIN i_housebank WITH PRIVILEGED ACCESS AS b ON ( b~bankinternalid = a~bankinternalid )
             WHERE a~bank = '373605010060071' ""wa_pay-fromaccountnumber
              INTO @DATA(housebank).
      DATA amount LIKE wa_pay-tranamount.
      amount = -1 * wa_pay-tranamount.


   DATA business TYPE C LENGTH 10 .

     CLEAR:businesspartner.
      SELECT SINGLE businesspartner FROM i_businesspartnerbank WITH PRIVILEGED ACCESS WHERE  bankaccount = @wa_pay-virtualaccountnumber
      INTO @businesspartner.

business = |{ businesspartner ALPHA = OUT }| .

      SELECT SINGLE profitcenter FROM zbank_tmg_table WITH PRIVILEGED ACCESS WHERE  customer = @business
      INTO @DATA(profitcenter).



      ar_item =  VALUE #( (
                          glaccountlineitem   = '010'
                          housebank           = housebank
                          customer            = businesspartner
                          housebankaccount    = housebank" wa_pay-fromaccountnumber
                          documentitemtext    = wa_pay-refnumber
                          assignmentreference = wa_pay-refnumber
                          businessplace       = '1010'
                          _currencyamount     = VALUE #( ( currencyrole           = '00'
                                                           journalentryitemamount = amount
                                                           currency               = 'INR' ) ) ) ).

      APPEND LINES OF ar_item  TO wa_je_deep-%param-_aritems.

      gl_item =  VALUE #( ( glaccountlineitem   = '020'
                            glaccount           = '1650003021'
                            businessplace       = '1010'
                            profitcenter        = profitcenter
                            valuedate           = wa_pay-trandate "wa_pay-creditdatetime
                            documentitemtext    = wa_pay-refnumber
                            assignmentreference = wa_pay-refnumber
                            housebank           = housebank
                            housebankaccount    = housebank "wa_pay-fromaccountnumber
                            _currencyamount     = VALUE #( ( currencyrole           = '00'
                                                             journalentryitemamount = wa_pay-tranamount
                                                             currency               = 'INR' ) ) ) ).
      APPEND LINES OF gl_item TO wa_je_deep-%param-_glitems.

      APPEND wa_je_deep TO lt_je_deep.
      CLEAR:wa_je_deep,gl_item,ar_item.

      MODIFY ENTITIES OF i_journalentrytp
      ENTITY journalentry
      EXECUTE post FROM lt_je_deep
      FAILED DATA(ls_failed_deep)
      REPORTED DATA(ls_reported_deep)
      MAPPED DATA(ls_mapped_deep).

      IF ls_failed_deep IS NOT INITIAL.
        LOOP AT ls_reported_deep-journalentry ASSIGNING FIELD-SYMBOL(<ls_reported_deep>).
          IF sy-tabix <> 1.
            IF <ls_reported_deep>-%msg->if_t100_dyn_msg~msgty = 'E'.
              DATA(lv_result) = <ls_reported_deep>-%msg->if_message~get_longtext( ).
              CONCATENATE '$$$$ Error :-' lv_result INTO responce .
              APPEND responce TO i_responce.
              CLEAR responce.

              res-transactionid = ''.
              res-code = 400.
              res-status =  <ls_reported_deep>-%msg->if_message~get_longtext( ).
              res-trandate  =  wa_json-trandate .
              res-refnumber = wa_json-refnumber.
              wa_pay-error = lv_result.
              MODIFY zbank_data1 FROM  @wa_pay .
            ENDIF.
          ENDIF.
        ENDLOOP.
      ELSE.
        COMMIT ENTITIES BEGIN
        RESPONSE OF i_journalentrytp
        FAILED DATA(lt_commit_failed)
        REPORTED DATA(lt_commit_reported).
        ...
        COMMIT ENTITIES END.


        LOOP AT lt_commit_reported-journalentry INTO DATA(w).
          IF w-%msg->if_t100_dyn_msg~msgty = 'S'.
            responce  = |$$$$ Document :-{ w-%msg->if_t100_dyn_msg~msgv2+0(10) } Generated|.
            APPEND responce TO i_responce.
            CLEAR responce.
            wa_pay-journalentryno = w-%msg->if_t100_dyn_msg~msgv2+0(10).

            res-transactionid = w-%msg->if_t100_dyn_msg~msgv2+0(10).
            res-code = 200.
            res-status = 'Success'.
            res-trandate  = wa_json-trandate. .
            res-refnumber = wa_json-refnumber.
            MODIFY zbank_data1 FROM  @wa_pay .
          ENDIF.
        ENDLOOP.
      ENDIF.
    ENDIF.
    IF it_alredy IS NOT INITIAL.
      res-transactionid = it_alredy-accountingdocument.
      res-code = 200.
      res-status = 'Success'.
      res-trandate  = wa_json-trandate .
      res-refnumber = wa_json-refnumber.
      CLEAR it_alredy.
    ENDIF.

"  DATA:json TYPE REF TO if_xco_cp_json_data.
    CLEAR:responce.

    xco_cp_json=>data->from_abap(
      EXPORTING
        ia_abap      = res "i_responce
      RECEIVING
        ro_json_data = json ).
    json->to_string(
      RECEIVING
        rv_string = responce ).

    REPLACE ALL OCCURRENCES OF 'CODE'  IN responce WITH 'code'.
    REPLACE ALL OCCURRENCES OF 'STATUS'  IN responce WITH 'status'.
    REPLACE ALL OCCURRENCES OF 'TRANSACTIONID'  IN responce WITH 'transactionid'.
    REPLACE ALL OCCURRENCES OF 'TRANDATE'  IN responce WITH 'trandate'.
    REPLACE ALL OCCURRENCES OF 'REFNUMBER'  IN responce WITH 'refnumber'.
    response->set_text( responce ).
ENDIF .

ENDMETHOD.
ENDCLASS.
