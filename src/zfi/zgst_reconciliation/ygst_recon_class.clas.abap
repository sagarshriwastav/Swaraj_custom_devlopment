
CLASS ygst_recon_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES  if_oo_adt_classrun.

    CLASS-DATA : access_token TYPE string .
    CLASS-DATA  : zgst_recon_data TYPE zgst_recon_data .

    TYPES:
      BEGIN OF post_s,
        user_id TYPE i,
        id      TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_s,

      BEGIN OF post_without_id_s,
        user_id TYPE i,
        title   TYPE string,
        body    TYPE string,
      END OF post_without_id_s.

    CLASS-METHODS :

      create_client

        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,

      gst_recon
        IMPORTING vbeln1          TYPE string OPTIONAL
                  datefrom        TYPE string
                  dateto          TYPE string
                  companycode     TYPE string
                  gstno           TYPE string
        RETURNING VALUE(gstrecon) TYPE string.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS YGST_RECON_CLASS IMPLEMENTATION.


  METHOD create_client.
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD.


  METHOD gst_recon.

    FIELD-SYMBOLS:
      <datax>  TYPE data,
      <datay>  TYPE data,
      <dataz>  TYPE data,
      <data2>  TYPE data,
      <data3>  TYPE any,
      <field>  TYPE any,
      <field1> TYPE any,
      <field2> TYPE any.

    DATA  gstinstats           TYPE string .
    DATA  gstin                TYPE string .
    DATA  totaldocumentcount   TYPE string .
    DATA  validrows            TYPE string .
    DATA  invalidrows          TYPE string .
    DATA  jsonrecorderrors     TYPE string .
    DATA  recordindex          TYPE string .
    DATA  externalid           TYPE string .
    DATA  externallineitemid   TYPE string .
    DATA  recorderrors         TYPE string .
    DATA  errorid              TYPE string .
    DATA  errormessage         TYPE string .
    DATA: lr_str TYPE REF TO data.


    DATA gv_from TYPE string .
    DATA gv1 TYPE string .
    DATA gv2 TYPE string .
    DATA gv3 TYPE string .

    gv3 = datefrom+6(4)  .
    gv2 = datefrom+3(2)  .
    gv1 = datefrom+0(2)  .

    CONCATENATE gv3  gv2  gv1 INTO gv_from .

    DATA gv_to TYPE string .
    DATA gv4 TYPE string .
    DATA gv5 TYPE string .
    DATA gv6 TYPE string .

    gv6 = dateto+6(4)  .
    gv5 = dateto+3(2)  .
    gv4 = dateto+0(2)  .

    CONCATENATE gv6  gv5  gv4 INTO gv_to .

    DATA: b_place TYPE string.

    IF gstno      = '08AAHCS2781A1ZH' .
      b_place     = '1010' .
    ELSEIF gstno  = '23AAHCS2781A1ZP' .
      b_place     = '1020' .
      ELSEIF gstno  = '08AABCM5293P1ZT' .
      b_place     = '2010' .
    ENDIF.
******************************************************APPEND LINE GSTR1 REPORTS*************************************************************

    SELECT * FROM YGSTR1_BILL_DATA_GST_RECON  WHERE billingdocumentdate GE @gv_from AND  billingdocumentdate LE @gv_to
             AND companycode = @companycode AND businessplace = @b_place AND BillingDocumentIsCancelled  IS NULL INTO TABLE @DATA(gstr1) .

    SELECT * FROM YGSTR1_N_B2CL
    WHERE companycode = @companycode AND businessplace = @b_place AND billingdocumentdate GE @gv_from AND
    billingdocumentdate LE @gv_to AND BillingDocumentIsCancelled  IS  NULL
    APPENDING CORRESPONDING FIELDS OF TABLE @gstr1 .

    SELECT * FROM YGSTR1_N_JV_FI
    WHERE companycode = @companycode AND businessplace = @b_place AND postingdate GE @gv_from
    AND postingdate LE @gv_to AND IsReversed IS  NULL
    APPENDING CORRESPONDING FIELDS OF TABLE @gstr1 .

    SELECT * FROM YGSTR1_N_CDNR
    WHERE companycode = @companycode AND businessplace = @b_place AND BillingDocumentIsCancelled  IS  NULL
     AND postingdate GE @gv_from AND postingdate LE @gv_to
    APPENDING CORRESPONDING FIELDS OF TABLE @gstr1  .

    SELECT * FROM YGSTR1_N_EXPORT
    WHERE  companycode = @companycode AND businessplace = @b_place AND billingdocumentdate GE @gv_from AND  billingdocumentdate LE @gv_to
    AND BillingDocumentIsCancelled  IS  NULL APPENDING CORRESPONDING FIELDS OF TABLE @gstr1 .
******************************************************APPEND LINE GSTR1 REPORTS*************************************************************


     READ TABLE gstr1 INTO DATA(wa_bill) INDEX 1.
   """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    SELECT SINGLE conditionrateratio FROM i_billingdocitemprcgelmntbasic
     WHERE billingdocument = @wa_bill-billingdocument AND billingdocumentitem = @wa_bill-billingdocumentitem
     INTO @DATA(gst_rate).

    SORT gstr1 ASCENDING BY billingdocument billingdocumentitem.
    DATA(gstr_hdr) = gstr1.
    DATA(LINE_ITEM) = GSTR1.
    DELETE ADJACENT DUPLICATES FROM gstr_hdr COMPARING billingdocument AccountingDocument .

    SORT gstr_hdr ASCENDING BY AccountingDocument.
    DELETE ADJACENT DUPLICATES FROM gstr_hdr COMPARING  AccountingDocument.
    SORT gstr_hdr ASCENDING BY billingdocument.


    DATA total   TYPE i .
    DATA success TYPE i .
    DATA fail    TYPE i .
    DATA TOT_SUM       TYPE STRING.
    DATA gst_cs_rate   TYPE zdec1.
    DATA gst_igst_rate TYPE zdec1.
    DATA ITEM_CATGRY   TYPE C.
    DATA CANCEL_DOC    TYPE C.
    DATA RCM           TYPE C.
    DATA rec(3)           TYPE C.
    DATA CHK(2)           TYPE C.

    DATA: billingdocument TYPE c LENGTH 10.
    DATA bracketo TYPE string .
    DATA bracketc TYPE string .
    DATA lv_xml   TYPE string .
    DATA lv_xml13 TYPE string .
    DATA lv_xml14 TYPE string .
    bracketo  = '{' .
    bracketc  = '}' .

    CLEAR: success,fail,total.
    DATA(sep) = ',' .
    DATA num TYPE i .
    total = lines( gstr_hdr ).


    LOOP AT gstr_hdr INTO DATA(wa_hdr).
*     DATA(sep) = ',' .
*    IF sy-tabix NE 1 .
*      CLEAR sep .
*    ENDIF .

    IF wa_hdr-AccountingDocumentType = 'DR'
    OR wa_hdr-AccountingDocumentType = 'DG'
    OR wa_hdr-AccountingDocumentType = 'AA'
    OR wa_hdr-AccountingDocumentType = 'SA'
    OR wa_hdr-AccountingDocumentType = 'DK'
    OR wa_hdr-AccountingDocumentType = 'SK'
    OR wa_hdr-AccountingDocumentType = 'DC'
    OR wa_hdr-AccountingDocumentType = 'DD'.
    wa_hdr-BillingDocument = wa_hdr-AccountingDocument.
    DELETE ADJACENT DUPLICATES FROM gstr1 COMPARING AccountingDocument .
    ELSE.
    GSTR1 = LINE_ITEM.
    ENDIF.


"""""""""""""Number Range For Group Id""""""""""""""""""""""
    DATA: nr_attribute TYPE cl_numberrange_objects=>nr_attribute,
          nr_number    TYPE cl_numberrange_runtime=>nr_number,
          nrnr         TYPE c LENGTH 2 VALUE '01',
          object       LIKE nr_attribute-object VALUE 'YGROUP_ID',
          quantity     TYPE n LENGTH 20 VALUE 1.


      TRY.
          CALL METHOD cl_numberrange_runtime=>number_get
            EXPORTING
              nr_range_nr = nrnr
              object      = object
              quantity    = quantity
            IMPORTING
              number      = nr_number.

        CATCH cx_nr_object_not_found.
        CATCH cx_number_ranges.
      ENDTRY.
      DATA(grp_id) = |{ |{ nr_number ALPHA = OUT }| ALPHA = IN }|.
      billingdocument = wa_hdr-billingdocument.

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
      DATA: fin_json TYPE string,
            tabix    TYPE sy-tabix.

      fin_json =
       |{ bracketo }"userInputArgs" :{ bracketo }"templateId":"618a5623836651c01c1498ad","groupId":"{ grp_id }","settings":{ bracketo }"ignoreHsnValidation":true{ bracketc }{ bracketc },| &&
       |"jsonRecords":[ | .

 clear: rec, CHK.
 LOOP AT gstr1 INTO DATA(iv) WHERE ( billingdocument = wa_hdr-billingdocument )
                                   OR ( AccountingDocument = wa_hdr-billingdocument  ).

*   DATA(sep) = ',' .
*    IF sy-tabix NE 1 .
*      CLEAR sep .
*    ENDIF .

    IF iv-AccountingDocumentType = 'DR'
    OR iv-AccountingDocumentType = 'DG'
    OR iv-AccountingDocumentType = 'AA'
    OR iv-AccountingDocumentType = 'SA'
    OR iv-AccountingDocumentType = 'DK'
    OR iv-AccountingDocumentType = 'SK'
    OR wa_hdr-AccountingDocumentType = 'DC'
    OR wa_hdr-AccountingDocumentType = 'DD'.
    iv-BillingDocument     = iv-AccountingDocument.
    iv-BillingDocumentDate = iv-PostingDate.

    ENDIF.

CLEAR: TOT_SUM.
  data(lv_tab)  = gstr1 .
  delete  lv_tab where billingdocument ne wa_hdr-billingdocument   .



   IF iv-AccountingDocumentType = 'DR'
    OR iv-AccountingDocumentType = 'DG'
    OR iv-AccountingDocumentType = 'AA'
    OR iv-AccountingDocumentType = 'SA'
    OR iv-AccountingDocumentType = 'DK'
    OR iv-AccountingDocumentType = 'SK'
    OR wa_hdr-AccountingDocumentType = 'DC'
    OR wa_hdr-AccountingDocumentType = 'DD'.

    lv_tab  = gstr1 .
    delete  lv_tab where  AccountingDocument ne wa_hdr-billingdocument .

    ENDIF.

 IF iv-AccountingDocumentType = 'DR'
    OR iv-AccountingDocumentType = 'DG'
    OR iv-AccountingDocumentType = 'AA'
    OR iv-AccountingDocumentType = 'SA'
    OR iv-AccountingDocumentType = 'DK'
    OR iv-AccountingDocumentType = 'SK'
    OR wa_hdr-AccountingDocumentType = 'DC'
    OR wa_hdr-AccountingDocumentType = 'DD'.

 SELECT SINGLE b~customername , b~region,b~taxnumber3,customerfullname FROM   I_OperationalAcctgDocItem AS a  INNER JOIN i_customer AS
             b ON   ( a~customer = b~customer  ) WHERE a~AccountingDocument = @iv-billingdocument AND A~CompanyCode = @IV-CompanyCode
             AND A~FiscalYear = @IV-FiscalYear AND a~FinancialAccountType = 'D' INTO  @DATA(buyeradd1)   .

ELSE.

  SELECT SINGLE b~customername , b~region,b~taxnumber3 , customerfullname FROM   i_billingdocumentpartner AS a  INNER JOIN i_customer AS
             b ON   ( a~customer = b~customer  ) WHERE a~billingdocument = @iv-billingdocument
              AND a~partnerfunction = 'RE' INTO  @buyeradd1   .

ENDIF.
"""""""""""""""""""Seller Address"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    SELECT SINGLE * FROM zsd_plant_address AS a INNER JOIN i_billingdocumentitembasic AS b ON ( a~plant =  b~plant )
    WHERE billingdocument =  @iv-billingdocument AND a~plant = @iv-Plant INTO @DATA(sellerplantaddress) .
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""Buyer Address"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    SELECT SINGLE * FROM   i_billingdocumentpartner AS a  INNER JOIN i_customer AS
             b ON   ( a~customer = b~customer  ) WHERE a~billingdocument = @iv-billingdocument
              AND a~partnerfunction = 'RE' INTO  @DATA(buyeradd)   .
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


     SELECT SINGLE * FROM i_regiontext WHERE region = @buyeradd1-region AND language = 'E' AND country = 'IN' INTO @DATA(state)  .
    IF buyeradd1-region = '37'.
      state-regionname = 'Andhra Pradesh'.
    ENDIF.

    SELECT SINGLE SDDocumentCategory FROM I_BillingDocumentBasic
    WHERE BillingDocument = @wa_hdr-billingdocument INTO @DATA(SDDocumentCategory) .

    SELECT SINGLE BillingDocumentType FROM I_BillingDocumentBasic
    WHERE BillingDocument = @wa_hdr-billingdocument INTO @DATA(BillingDocumentType) .
    DATA INV TYPE STRING .



  IF SDDocumentCategory = 'O'.
        INV = 'CRN'.
 ELSEIF SDDocumentCategory = 'P'.
      INV = 'DBN'.
 ELSEIF SDDocumentCategory = 'U'.
       INV = 'PINV'.
  ELSEIF iv-AccountingDocumentType = 'DG' .
  INV  =  'CRN' .
  ELSEIF iv-AccountingDocumentType = 'DC' OR  iv-AccountingDocumentType = 'DD'.
  INV  =  'DBN' .
  ELSE .
  INV = 'INV'.
  ENDIF .

 loop at lv_tab into data(w_a) .

                IF w_a-cgst < 0.
                   w_a-cgst = w_a-cgst * -1.
                ENDIF.
                IF w_a-sgst < 0.
                   w_a-sgst = w_a-sgst * -1.
                ENDIF.
                IF w_a-igst < 0.
                   w_a-igst = w_a-igst * -1.
                ENDIF.
                IF w_a-netamount < 0.
                   w_a-netamount = w_a-netamount * -1.
                ENDIF.

                IF iv-sgst IS INITIAL.
                  iv-sgst = iv-cgst.
                ENDIF.
                IF iv-cgst IS INITIAL.
                  iv-cgst = iv-sgst.
                ENDIF.


  DATA(total_amt)    = w_a-netamount + w_a-cgst + w_a-sgst + w_a-igst.
        TOT_SUM =  TOT_SUM + total_amt .
  endloop .

  clear total_amt .

        tabix = sy-tabix.
        DATA gv TYPE string .
        DATA d1 TYPE string .
        DATA d2 TYPE string .
        DATA d3 TYPE string .

        d3 = iv-billingdocumentdate+0(4)  .
        d2 = iv-billingdocumentdate+4(2)  .
        d1 = iv-billingdocumentdate+6(2)  .
        CONCATENATE d1 '/' d2 '/' d3 INTO gv .


"""""""""""""""""""""""""""""""""""""""Document Type...............................
        IF iv-billingdocumenttype = 'F2'.
          DATA(doc_typ) = 'INV'.
        ENDIF.
""""""""""""""""""""""""""""""""""""""""Goods & Service Indicator..................
*         DATA: LEN TYPE C.


 IF iv-AccountingDocumentType = 'DR'
    OR iv-AccountingDocumentType = 'DG'
    OR iv-AccountingDocumentType = 'AA'
    OR iv-AccountingDocumentType = 'SA'
    OR iv-AccountingDocumentType = 'DK'
    OR iv-AccountingDocumentType = 'SK'
    OR wa_hdr-AccountingDocumentType = 'DC'
    OR wa_hdr-AccountingDocumentType = 'DD'.
  IF  iv-ConsumptionTaxCtrlCode  IS INITIAL .
    SELECT SINGLE IN_HSNOrSACCode FROM YGSTR1_N_JV_FI
   WHERE AccountingDocument = @iv-AccountingDocument AND CompanyCode  = @iv-CompanyCode AND FiscalYear = @iv-FiscalYear
     AND BusinessPlace = @iv-BusinessPlace INTO @DATA(consumptiontaxctrlcode) .
   ENDIF.
    ELSE.
   IF  iv-ConsumptionTaxCtrlCode  IS INITIAL .
     SELECT SINGLE consumptiontaxctrlcode FROM YGSTR1_BILL_DATA WHERE BillingDocument = @iv-BillingDocument AND CompanyCode  = @iv-CompanyCode AND FiscalYear = @iv-FiscalYear
     AND BusinessPlace = @iv-BusinessPlace INTO @consumptiontaxctrlcode .
   ELSE.
   consumptiontaxctrlcode  =  iv-ConsumptionTaxCtrlCode .
   ENDIF.
    ENDIF.
          DATA: LEN(2) type C .
         LEN = consumptiontaxctrlcode+0(2).
         IF LEN = '99'.
            ITEM_CATGRY = 'S'.
              ELSE. ITEM_CATGRY = 'G'.
                 ENDIF.
""""""""""""""""""""""""""""""""""""""""Cancelled Document Indicator...............
        IF IV-CancelledBillingDocument = 'X'.
           CANCEL_DOC = 'Y'.
              ELSE.  CANCEL_DOC = 'N'.
                  ENDIF.
""""""""""""""""""""""""""""""""""""""""RCM Indicator..............................
         IF IV-CompanyCode = '4000'.
           RCM = 'Y'.
              ELSE.  RCM = 'N'.
                  ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

        if iv-netamount is not INITIAL .
        GST_CS_RATE = ( iv-cgst * 100 ) / iv-netamount.
            if GST_CS_RATE = '2.6' or GST_CS_RATE = '2.7' or GST_CS_RATE = '2.8' or GST_CS_RATE = '2.9'.
               iv-rate = '2.5'.
             else. iv-rate = GST_CS_RATE.
            endif.
        GST_IGST_RATE = ( iv-igst * 100 ) / iv-netamount.
        endif .

                IF iv-cgst < 0.
                  iv-cgst = iv-cgst * -1.
                ENDIF.

                IF iv-sgst < 0.
                  iv-sgst = iv-sgst * -1.
                ENDIF.

                IF iv-igst < 0.
                  iv-igst = iv-igst * -1.
                ENDIF.

                IF iv-netamount < 0.
                  iv-netamount = iv-netamount * -1.
                ENDIF.

*********************************For Jv Documents Only
 IF iv-AccountingDocumentType = 'DR'
    OR iv-AccountingDocumentType = 'DG'
    OR iv-AccountingDocumentType = 'AA'
    OR iv-AccountingDocumentType = 'SA'
    OR iv-AccountingDocumentType = 'DK'
    OR iv-AccountingDocumentType = 'SK'
    OR wa_hdr-AccountingDocumentType = 'DC'
    OR wa_hdr-AccountingDocumentType = 'DD'.
clear TOT_SUM .

  SELECT  SUM( TaxBaseAmountInCoCodeCrcy ) FROM YGSTR1_N_JV_FI
   WHERE AccountingDocument = @iv-AccountingDocument AND CompanyCode  = @iv-CompanyCode AND FiscalYear = @iv-FiscalYear
     AND BusinessPlace = @iv-BusinessPlace  INTO @DATA(TaxBaseAmountInCoCodeCrcy) .

               IF TaxBaseAmountInCoCodeCrcy < 0.
                  TaxBaseAmountInCoCodeCrcy = TaxBaseAmountInCoCodeCrcy * -1.
                ENDIF.
*    iv-netamount  =   TaxBaseAmountInCoCodeCrcy.
    TOT_SUM   = TOT_SUM + TaxBaseAmountInCoCodeCrcy .       "+ iv-cgst + iv-sgst + iv-igst.



  IF IV-NetAmount IS INITIAL.
   SELECT TaxBaseAmountInCoCodeCrcy FROM YGSTR1_N_JV_FI
   WHERE AccountingDocument = @iv-AccountingDocument AND CompanyCode  = @iv-CompanyCode AND FiscalYear = @iv-FiscalYear
     AND BusinessPlace = @iv-BusinessPlace  INTO TABLE @DATA(TAXABLE_AMT) .

   CHK = CHK + 1.
   READ TABLE TAXABLE_AMT INTO DATA(WT) INDEX CHK.
   IV-NetAmount = WT-TaxBaseAmountInCoCodeCrcy.

   IF IV-NetAmount < 0 .
      IV-NetAmount = IV-NetAmount * -1.
      ENDIF.

   ENDIF.





""""""""""""""""""""""""""""""""""FOR GST RATE"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
CLEAR: GST_CS_RATE, GST_IGST_RATE.
     SELECT SINGLE * FROM ytax_code2 WHERE taxcode = @IV-TaxCode  INTO @DATA(TAXRATE)  .

     IF IV-CGST IS NOT INITIAL.
        GST_CS_RATE = TAXRATE-gstrate.
       ELSEIF IV-IGST IS NOT INITIAL.
              GST_IGST_RATE  = TAXRATE-gstrate.
                ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*       if iv-netamount is not INITIAL .
*
*        GST_CS_RATE = ( iv-cgst * 100 ) / iv-netamount.
*           if GST_CS_RATE = '2.6' or GST_CS_RATE = '2.7' or GST_CS_RATE = '2.8' or GST_CS_RATE = '2.9'.
*             iv-rate = '2.5'.
*          else. iv-rate = GST_CS_RATE.
*          endif.
*        GST_IGST_RATE = ( iv-igst * 100 ) / iv-netamount.
*        endif .
*
    ENDIF.
******************************

  DATA(reco) = lines( lv_tab ) .
         rec = rec + 1.

         IF rec NE 1.
*        IF tabix NE 1.
          fin_json = fin_json && sep.
        ENDIF.
        fin_json = fin_json &&
            |{ bracketo }"documentType":"{ INV }","documentDate": "{ gv }" ,"documentNumber": "{ billingdocument }",| &&
            |"erpSource":"SAP","voucherNumber":"{ billingdocument  }","voucherDate":"{ gv }",| &&
            |"isBillOfSupply":"N","isReverseCharge":"{ rcm }","isDocumentCancelled":"{ CANCEL_DOC }",| &&
            |"supplierName":"{ sellerplantaddress-a-plantname }","supplierGstin":"{ gstno }","customerName":"{ buyeradd1-customername }","customerAddress":"{ buyeradd1-customerfullname }","customerState":"{ buyeradd1-region }", | &&
            |"customerGstin":"{ buyeradd1-taxnumber3 }","placeOfSupply":"{ state-regionname }",| &&
         | "itemDescription":"{ iv-billingdocumentitem }","itemCategory":"{ ITEM_CATGRY }",| &&
         |"hsnSacCode":"{ consumptiontaxctrlcode }","itemQuantity":{ iv-billingquantity },"itemUnitPrice":{ iv-rate },"itemDiscount":"0.00","itemTaxableAmount":{ iv-netamount },| &&
         |"cgstRate":{ iv-rate },"cgstAmount":{ iv-cgst },"sgstRate":{ iv-rate },"sgstAmount":{ iv-sgst },"igstRate":{ GST_IGST_RATE },"igstAmount":{ iv-igst },"cessRate":0,"cessAmount":0, | &&
         |"documentTotalAmount":{ tot_sum } { bracketc } | .

      ENDLOOP.
      fin_json = fin_json && |]{ bracketc }|.

      DATA(status1)  =  ycl_gst_recon_api=>postclear_tax( json =  fin_json GSTIN = |{ GSTNO }| billingdocument = |{ billingdocument }| ) .

      DATA(lr_d1) = /ui2/cl_json=>generate( json = status1 ).

      IF lr_d1 IS BOUND.
      ASSIGN lr_d1->* TO <datax>.
      IF <datax> IS ASSIGNED .
      ASSIGN COMPONENT 'jsonRecordErrors' OF STRUCTURE <datax>  TO   <field>    .
      IF sy-subrc = 0 .
      ASSIGN <field>->* TO <data2>  .
      IF <data2> IS ASSIGNED .
      LOOP AT <data2> ASSIGNING FIELD-SYMBOL(<ls_data2>).
      ASSIGN COMPONENT 'RECORDERRORS' OF STRUCTURE <ls_data2> TO FIELD-SYMBOL(<fs>).
      IF <fs> IS ASSIGNED.
      ELSE.
      ASSIGN <ls_data2>->* TO FIELD-SYMBOL(<lt_fs>).
      IF <lt_fs> IS ASSIGNED.
      ASSIGN COMPONENT 'RECORDERRORS' OF STRUCTURE <lt_fs> TO FIELD-SYMBOL(<fs2>).
      IF <fs2> IS ASSIGNED.
      ASSIGN <fs2>->* TO FIELD-SYMBOL(<fs4>).
      IF <fs4> IS ASSIGNED.
      LOOP AT <fs4> ASSIGNING FIELD-SYMBOL(<fs5>).
      IF <fs5> IS ASSIGNED.
      ASSIGN COMPONENT 'ERRORMESSAGE' OF STRUCTURE <fs5> TO FIELD-SYMBOL(<fs6>).
      IF <fs6> IS ASSIGNED.
      ELSE.
      ASSIGN <fs5>->* TO FIELD-SYMBOL(<fs7>).
      IF <fs7> IS ASSIGNED.
      ASSIGN COMPONENT `ERRORMESSAGE` OF STRUCTURE <fs7>  TO   <field1>    .
      IF sy-subrc = 0 .
      ASSIGN <field1>->* TO <field1> .
      errormessage = <field1> .
      ENDIF.
      ENDIF.
      ENDIF.
      ENDIF.
      ENDLOOP.
      ENDIF.
      ENDIF.
      ENDIF.
      ENDIF.
      ENDLOOP.
      ENDIF.
      ENDIF.
      ENDIF.
      ENDIF.

      zgst_recon_data-templateid       =  '618a5623836651c01c1498ad' .
      zgst_recon_data-groupid          =  grp_id .
      zgst_recon_data-documenttype     = 'Invoice' .
      zgst_recon_data-documentdate     =  iv-billingdocumentdate .
      zgst_recon_data-documentnumber   = iv-billingdocument  .
      zgst_recon_data-erpsource        = 'SAP' .
      zgst_recon_data-vouchernumber    = iv-billingdocument  .
      zgst_recon_data-voucherdate      = iv-billingdocumentdate  .
      zgst_recon_data-responce         = errormessage .
      zgst_recon_data-error_message    = errormessage.

      zgst_recon_data-fiscalyear       =  wa_hdr-fiscalyear.
      zgst_recon_data-companycode      =  wa_hdr-companycode.
      zgst_recon_data-businessplace    =  wa_hdr-businessplace.
      zgst_recon_data-igstrate         =  gst_igst_rate.
      zgst_recon_data-igstamount       =  iv-igst.
      zgst_recon_data-cgstrate         =  iv-rate.
      zgst_recon_data-cgstamount       =  iv-cgst.
      zgst_recon_data-sgstrate         =  iv-rate.
      zgst_recon_data-sgstamount       =  iv-sgst.
      zgst_recon_data-itemtaxableamount =  tot_sum.
      zgst_recon_data-customer_gstin   =  buyeradd-b-taxnumber3.
      zgst_recon_data-supp_gstin       =  gstno .
      zgst_recon_data-supplier_name    =  sellerplantaddress-a-plantname.
      zgst_recon_data-report    =   'Sales'   .

      IF errormessage IS NOT INITIAL.
        zgst_recon_data-success_indctr = 'E' .
        fail = fail + 1.
      ELSE.
        zgst_recon_data-success_indctr = 'S' .
        success = success + 1.
      ENDIF.

      MODIFY zgst_recon_data FROM @zgst_recon_data .
      CLEAR : iv, errormessage, zgst_recon_data, buyeradd1,state ,INV,SDDocumentCategory,BillingDocumentType,TaxBaseAmountInCoCodeCrcy. .
      DELETE gstr1 WHERE billingdocument = wa_hdr-billingdocument.

*        GSTR1 = LINE_ITEM.
*        DELETE GSTR1 WHERE AccountingDocument = wa_hdr-AccountingDocument.

    ENDLOOP.

    gstrecon = |Total { total } Documents, where { success } Documents Pushed Suscessfully and { fail } Failed | .

  ENDMETHOD.


  METHOD if_oo_adt_classrun~main.

*    DATA: vbeln1 TYPE string.
*    TRY.
*        DATA(return_data) = gst_recon(  datefrom = '01/11/2022'  dateto = '30/11/2022' companycode = '1000' gstno = '08AAICR3451R1ZP' ).
*    ENDTRY.

  ENDMETHOD.
ENDCLASS.
