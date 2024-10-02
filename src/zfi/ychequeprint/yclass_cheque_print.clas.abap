CLASS yclass_cheque_print DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
    CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
    TYPES :
      BEGIN OF struct,
        xdp_template TYPE string,
        xml_data     TYPE string,
        form_type    TYPE string,
        form_locale  TYPE string,
        tagged_pdf   TYPE string,
        embed_font   TYPE string,
      END OF struct."


    CLASS-METHODS :
      create_client
        IMPORTING url           TYPE string
        RETURNING VALUE(result) TYPE REF TO if_web_http_client
        RAISING   cx_static_check ,

      read_posts
        IMPORTING variable        TYPE string
                  variable2       TYPE string
                  housebank       TYPE string
                  accountpayee    TYPE string
                  chekbackside    TYPE string
                  self            TYPE string
                  rtgs            TYPE string
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .
  PROTECTED SECTION.

  PRIVATE SECTION.
    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'HDFC_CHECK/HDFC_CHECK'.
*    CONSTANTS lc_template_name TYPE 'HDFC_CHECK/HDFC_MULTI_FINAL_CHECK'.

ENDCLASS.



CLASS YCLASS_CHEQUE_PRINT IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


  METHOD read_posts .


    SELECT * FROM ychequeprint_ WHERE OutgoingCheque GE @variable AND OutgoingCheque LE @variable2 AND HouseBank = @housebank
  INTO table  @DATA(chequedatatable).

  LOOP AT chequedatatable INTO DATA(WA_CHEQUE).
  DATA(WACHQ) = WA_CHEQUE.
  ENDLOOP.

  SELECT SINGLE * FROM ychequeprint_ WHERE OutgoingCheque GE @variable AND OutgoingCheque LE @variable2 INTO  @DATA(chequedata).
  SELECT SINGLE * FROM i_outgoingcheck WHERE outgoingcheque GE @variable AND OutgoingCheque LE @variable2 INTO  @DATA(chequedata1) .

*    SELECT SINGLE *  FROM ychequeprint_ WHERE outgoingcheque = @variable
*    INTO @DATA(chequedata)  .
*    SELECT SINGLE * FROM i_outgoingcheck WHERE outgoingcheque = @variable INTO  @DATA(chequedata1) .
    DATA lc_template_name TYPE string.
    SELECT SINGLE bankbranch FROM i_bank_2 WHERE BankName = @WACHQ-BankName  INTO @DATA(brach).
    SELECT SINGLE  bankaccount FROM i_housebankaccountlinkage WHERE housebank = @WACHQ-housebank INTO @DATA(bankacount).

""""""""""""""""""""
  SELECT SINGLE * FROM i_outgoingcheck WHERE OutgoingCheque GE @variable AND OutgoingCheque LE @variable2  AND HouseBank = @housebank INTO  @DATA(iout) .
*  SELECT SINGLE DOCUMENTDATE FROM I_OperationalAcctgDocItem WHERE AccountingDocument = @iout-PaymentDocument and CompanyCode = @iout-PaymentCompanyCode
*   and  FiscalYear = @iout-FiscalYear INTO @DATA(docdate).


""""""""""""""""""""
    DATA lv_xml11 TYPE string .
    DATA selfpynam TYPE string.
    DATA bank TYPE string.
    data lv_xml111 type string.

    IF self = 'true'.
      selfpynam = 'SELF'.
    ELSEIF rtgs = 'true'.
      selfpynam = 'Your Self RTGS'.
    ELSE.
      selfpynam = chequedata1-payeename.
    ENDIF.
    IF chekbackside = 'true'.
      lc_template_name = 'FI_CHEQUE/FI_CHEQUE_ALL'.
      CONCATENATE chequedata1-chequepaymentdate+6(2) chequedata1-chequepaymentdate+4(2) chequedata1-chequepaymentdate+0(4) INTO chequedata1-chequepaymentdate .


    ELSE.
        lc_template_name = 'HDFC_CHECK/HDFC_CHECK'.



data(lv1)  =  |<form1>|  .
data(lv2)  =  |</form1>|  .



loop at chequedatatable into data(wa)  .


   SELECT SINGLE ACCOUNTINGDOCUMENT,  DOCUMENTDATE FROM I_OperationalAcctgDocItem WHERE
   AccountingDocument = @wa-PaymentDocument and CompanyCode = @wa-PaymentCompanyCode
   and  FiscalYear = @wa-FiscalYear INTO  @DATA(docdate).



SELECT SINGLE * FROM I_Supplier WHERE Supplier = @WA_CHEQUE-Supplier INTO @DATA(SUPPLIER).

IF SUPPLIER-SupplierName IS INITIAL.
SUPPLIER-SupplierName = 'SELF'.
ENDIF.

 lv_xml11 =

*   |<Page1>| &&
*      |<Subform1>| &&
**      |<PayName>{ WA-payeename } { WA-PayeeAdditionalName }</PayName>| &&
*      |<PayName>{ SUPPLIER-SupplierName }</PayName>| &&
*      |<Amount>{ WA-PaidAmountInPaytCurrency }</Amount>| &&
*      |<Date>{ docdate-DocumentDate  }</Date>| &&
*      |</Subform1>| &&
*      |</Page1>|.


|<form1>| &&
|<Page1>| &&
  |<Subform1>| &&
         |<PayName>{ SUPPLIER-SupplierName }</PayName>| &&
         |<Amount>{ WA-PaidAmountInPaytCurrency }</Amount>| &&
         |<Date>{ docdate-DocumentDate  }</Date>| &&
      |</Subform1>| &&
   |</Page1>| &&
|</form1>|.


lv_xml111 = lv_xml111 && lv_xml11 .

endloop .



lv_xml111  = lv1 && lv_xml111 && lv2 .
CONCATENATE docdate-DocumentDate+6(2) docdate-DocumentDate+4(2) docdate-DocumentDate+0(4) INTO docdate-DocumentDate .
*  lv_xml11 =
*      |<form1>| &&
*      |<Page1>| &&
*      |<Subform1>| &&
*      |<PayName>{ chequedata1-payeename }</PayName>| &&
*      |<Amount>{ chequedata-PaidAmountInPaytCurrency  }</Amount>| &&
*      |<Date>{ chequedata-ChequePaymentDate }</Date>| &&
*      |</Subform1>| &&
*      |</Page1>| &&
*      |</form1>|.

    ENDIF.

CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = lv_xml11
         template = lc_template_name
       RECEIVING
         result   = result12 ).

  ENDMETHOD .
ENDCLASS.
