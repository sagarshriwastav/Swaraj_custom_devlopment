CLASS zsd_performa_invoice_adobe DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

  INTERFACES if_oo_adt_classrun .


    CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
    CLASS-DATA : template TYPE string .
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

        IMPORTING

                   plant type string
       PERFORMADOCUMENT  type  string



        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.

  CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token' .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'PERFORMA__INVOICE/PERFORMA__INVOICE'.

ENDCLASS.



CLASS ZSD_PERFORMA_INVOICE_ADOBE IMPLEMENTATION.


 METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).

  ENDMETHOD .


   METHOD if_oo_adt_classrun~main.

DATA(TEST)  = READ_POSTS(  PERFORMADOCUMENT = '5000000249'  plant = ' ' )  .

  ENDMETHOD.


  METHOD read_posts .

  data   lv_xml type string.

   DATA:LV  TYPE  C LENGTH 100   .
   DATA VAR1 TYPE ZCHAR10.
   DATA VAR2 TYPE ZCHAR10.
   VAR1 = PERFORMADOCUMENT.
   VAR1 =   |{ VAR1  ALPHA = IN }| .

  select * from  I_BillingDocumentItem  where BillingDocument  = @VAR1 into TABLE @data(it) .

   SELECT SINGLE * FROM  I_BillingDocumentPartner as bILLINGPARTNR
   LEFT OUTER JOIN i_customer as b ON ( b~Customer = bILLINGPARTNR~Customer )
   LEFT OUTER JOIN zsd_dom_address WITH PRIVILEGED ACCESS as c ON ( c~AddressID = b~AddressID )
   where  BillingDocument   = @VAR1  and  PartnerFunction = 'RE' INTO @DATA(billtoadd1)   .



* DATA(lv_xml) =
   lv_xml =

   |<form1>| &&
   |<Subform1>| &&
   |<PLANTADDRESSSUBFORM/>| &&
   |<imagesubform/>| &&
   |<Subform2>| &&
   |<PROFORMAINVOICENO>{ PERFORMADOCUMENT }</PROFORMAINVOICENO>| &&
   |<DATE></DATE>| &&
   |<BUYER>{ billtoadd1-c-addresseefullname }</BUYER>| &&
   |<Buyeradd>{ billtoadd1-c-streetprefixname1 }</Buyeradd>| &&
   |<Buyeradd1>{ billtoadd1-C-streetprefixname2 }</Buyeradd1>| &&
   |<Buyeradd2>{ billtoadd1-c-streetsuffixname1 }   { billtoadd1-c-streetsuffixname2 }</Buyeradd2>| &&
   |<Buyeradd3>{ billtoadd1-b-cityname }({ billtoadd1-b-postalcode  })</Buyeradd3>| &&
   |</Subform2>| &&
   |<DEARSUBFORM/>| &&
   |<Table1>| &&
   |<Row1/>| .

      SELECT SINGLE AccountingExchangeRate FROM I_BillingDocument WHERE BillingDocument = @VAR1
                                          INTO @DATA(AccountingExchangeRate) .

  LOOP AT it INTO DATA(WA).

     DATA AMTINR TYPE P DECIMALS 2.
     DATA TOTQTY TYPE P DECIMALS 2.
      DATA TOTAMTINR TYPE P DECIMALS 2.

     AMTINR  = WA-NetAmount  * AccountingExchangeRate .
     TOTQTY  =  TOTQTY + WA-BillingQuantity.
     TOTAMTINR  =  TOTAMTINR + AMTINR .

         lv_xml = lv_xml &&
         |<Row2>| &&
         |<SortNo>{ WA-Material }</SortNo>| &&
         |<DETAILS>{ WA-BillingDocumentItemText }</DETAILS>| &&
         |<Quantity>{ WA-BillingQuantity }</Quantity>| &&
         |<PriceinYard>{ WA-TaxAmount }</PriceinYard>| &&
         |<ValueINR>{ AMTINR }</ValueINR>| &&
         |</Row2>| .
         CLEAR:AMTINR, WA.

ENDLOOP.
   DATA terms1 TYPE string .

    SELECT SINGLE * FROM i_billingdocumentbasic WHERE billingdocument =  @var1  INTO @DATA(billhead) .
     SELECT SINGLE * FROM i_paymenttermstext WHERE paymentterms = @billhead-customerpaymentterms AND language = 'E'
    INTO @DATA(terms) .

  IF terms-paymenttermsname <> '' .
        terms1 = terms-paymenttermsname  .
  ELSE.
      terms1 = terms-PaymentTermsDescription  .
  ENDIF.

         lv_xml = lv_xml &&
         |</Table1>| &&
         |<Row3>| &&
         |<TotalQuantity>{ TOTQTY }</TotalQuantity>| &&
         |<TotalValue>{ TOTAMTINR }</TotalValue>| &&
         |</Row3>| &&
         |<TERMSOFPAYMENT>{ terms1 }</TERMSOFPAYMENT>| &&
         |<BANKNAME>{ 'BANK OF INDIA' }</BANKNAME>| &&
         |<BRANCH>{ 'BANK OF BARODA SME BRANCH' }</BRANCH>| &&
         |<BRANCHADD>{ '1ST FLOOR PANCHAL CHOURAHA PUR ROAD' }</BRANCHADD>| &&
         |<BRANCHADD1>{ 'BHILWARA, RAJASTHAN-311001 , INDIA' }</BRANCHADD1>| &&
         |<swiftcodeno>{ 'BARBINBBSBW' }</swiftcodeno>| &&
         |<subformbenificiary>| &&
         |<BENEFICIARY>{ 'SWARAJ SUITING LTD' }</BENEFICIARY>| &&
         |<ADDRESS>{ ' BHILWARA ( RJ) - INDIA' }</ADDRESS>| &&
         |</subformbenificiary>| &&
         |<SHIPMENTSCHEDULE>{ 'DELIVERY - EX-MILL 17TH DEC,2023' }</SHIPMENTSCHEDULE>| &&
         |<SHIPPINGMARK></SHIPPINGMARK>| &&
         |<PartialShipment>{ 'Allowed' }</PartialShipment>| &&
         |<HSCode></HSCode>| &&
         |<TextField1></TextField1>| &&
         |<TextField2></TextField2>| &&
         |<buyersellersubform>| &&
         |<confirmedbuyer></confirmedbuyer>| &&
         |<confirmedseller></confirmedseller>| &&
         |</buyersellersubform>| &&
         |</Subform1>| &&
         |</form1>|.


   CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = lc_template_name
       RECEIVING
                result   = result12 ).

*  ENDMETHOD.
 ENDMETHOD.
ENDCLASS.
