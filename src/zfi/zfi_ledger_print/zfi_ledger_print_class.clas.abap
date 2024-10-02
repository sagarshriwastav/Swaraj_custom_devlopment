CLASS zfi_ledger_print_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
    CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .
    CLASS-DATA : template TYPE string .
    CLASS-DATA : tot_sum  TYPE string.

    TYPES : BEGIN OF struct,
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
        RAISING   cx_static_check,

      read_posts
        IMPORTING VALUE(companycode) TYPE string
                  VALUE(datefrom)    TYPE string
                  VALUE(dateto)      TYPE string
                  VALUE(glcodefrom)  TYPE string

        RETURNING VALUE(result12)    TYPE string
        RAISING   cx_static_check .


  PROTECTED SECTION.
  PRIVATE SECTION.


    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
 CONSTANTS  lc_template_name TYPE string VALUE 'LEDGERSTATEMENTPRINT/LEDGERSTATEMENTPRINT'.

ENDCLASS.



CLASS ZFI_LEDGER_PRINT_CLASS IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.
    TRY.
    ENDTRY.
  ENDMETHOD.


  METHOD read_posts .
    DATA lv_xml TYPE string.
    DATA XSML TYPE STRING.
    DATA date2 TYPE string.
    DATA gv1 TYPE string .
    DATA gv2 TYPE string .
    DATA gv3 TYPE string .

    gv3 = datefrom+6(4)  .
    gv2 = datefrom+3(2)  .
    gv1 = datefrom+0(2)  .

    CONCATENATE gv3 gv2 gv1   INTO date2.

    DATA date3 TYPE string.
    DATA gv4 TYPE string .
    DATA gv5 TYPE string .
    DATA gv6 TYPE string .

    gv6 = dateto+6(4)  .
    gv5 = dateto+3(2)  .
    gv4 = dateto+0(2)  .

    CONCATENATE gv6 gv5 gv4  INTO date3.

    SELECT DISTINCT
            A~accountingdocument ,
            A~documentdate,
            A~companycode,
            A~accountingdocumenttype,
            A~fiscalyear,
            SUM( A~amountincompanycodecurrency ) AS amountincompanycodecurrency,
            A~debitcreditcode ,
            A~withholdingtaxamount,
            A~glaccount,
            A~postingdate,
            B~glaccountlongname,
            C~IsReversal,
            C~IsReversed

             FROM i_operationalacctgdocitem as a
             INNER JOIN i_glaccounttextincompanycode AS B ON  ( B~glaccount = A~glaccount
                                                     AND B~COMPANYCODE = A~companycode
                                                     AND B~Language = 'E' )
             INNER JOIN I_JournalEntry  as c ON (  c~AccountingDocument = a~AccountingDocument
                                                    AND c~CompanyCode = a~CompanyCode
                                                    AND c~FiscalYear = a~FiscalYear
                                                    AND c~IsReversal <> 'X' AND c~IsReversed <> 'X')
 WHERE A~glaccount = @glcodefrom  AND A~companycode = @companycode AND A~postingdate BETWEEN @date2 AND @date3
     GROUP BY A~accountingdocument ,
            A~documentdate,
            A~companycode,
            A~accountingdocumenttype,
            A~fiscalyear,
            A~debitcreditcode ,
            A~withholdingtaxamount,
            A~glaccount,
            A~postingdate,
            B~glaccountlongname,
            C~IsReversal,
            C~IsReversed
    INTO TABLE @DATA(it_tab).



IF IT_TAB IS NOT INITIAL.
READ TABLE IT_TAB INTO DATA(WA_TAB) INDEX 1.
ENDIF.


IF WA_TAB IS NOT INITIAL.
    SELECT SUM( AMOUNTINCOMPANYCODECURRENCY )
       FROM i_operationalacctgdocitem
       WHERE glaccount = @WA_TAB-glaccount AND
        CompanyCode = @WA_TAB-companycode AND
        postingdate LT @date2 INTO @DATA(OPENING).

     SELECT SUM( AMOUNTINCOMPANYCODECURRENCY )
       FROM i_operationalacctgdocitem
       WHERE Glaccount = @WA_TAB-glaccount AND
        CompanyCode = @WA_TAB-companycode
        AND PostingDate LE @date3 INTO @DATA(CLOSING_BAL).
 ENDIF.
   DATA(CLOSING) =  CLOSING_BAL.

   IF companycode   =  '1000' .
     data(gst1)  = '08AAHCS2781A1ZH'.
     data(pan1)  = 'AAHCS2781A'.
     DATA(Register1) = 'SWARAJ SUITING LIMITED'.
     data(Register2) = 'F-483 To F-487 RIICO Growth Centre' .
     DATA(Register3) = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
     data(cin1) = 'L18101RJ2003PLC018359'.

     elseif companycode   =  '2000' .
     gst1  = '08AABCM5293P1ZT'.
     pan1  = 'AABCM5293P'.
     Register1 = 'MODWAY SUITING PVT. LIMITED'.
     Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
     Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
     cin1 = 'U18108RJ1986PTC003788'.
ENDIF.



*data : date type DATS.
*data : d1 type string.
*data : d2 type string.
*data : d3 type string.
*
*       date = sy-datum.
*       d1 = date+0(4).
*       d2 = date+4(2).
*       d3 = date+6(2).
*
*       CONCATENATE d3  d2  d1 INTO DATA(date1).


    LV_Xml = |<form1>| &&
   |<plantname>{ Register1 }</plantname>| &&
   |<address1>{ Register2 }</address1>| &&
   |<address2>{ Register3 }</address2>| &&
   |<address3></address3>| &&
   |<CINNO>{  cin1 }</CINNO>| &&
   |<GSTIN>{ GST1 }</GSTIN>| &&
   |<PAN>{ PAN1 }</PAN>| &&
   |<LeftSide>| &&
      |<GLACCOUNTNO>{ WA_TAB-glaccount }</GLACCOUNTNO>| &&
      |<GLDESCRIPTION>{ WA_TAB-glaccountlongname  }</GLDESCRIPTION>| &&
   |</LeftSide>| &&
   |<RightSide>| &&
*      |<date>{ DATE }</date>| &&
      |<openingbl>{ OPENING }</openingbl>| &&
      |<FromDate>{ datefrom }</FromDate>| &&
      |<ToDate>{ dateto  }</ToDate>| &&
   |</RightSide>|.



   DATA : SUM TYPE STRING.
   DATA : SUM1 TYPE STRING.
   DATA: SUM2 TYPE STRING.

SORT IT_TAB BY POSTINGDATE.
  loop at it_TAB INTO wa_TAB.

 SELECT SINGLE a~AccountingDocument,a~OffsettingAccount,b~suppliername,c~CustomerName ,d~glaccountlongname FROM I_JournalEntryItem AS A
 LEFT OUTER JOIN I_Supplier AS B on ( B~Supplier = a~OffsettingAccount )
 LEFT OUTER JOIN I_Customer AS c on ( c~Customer = a~OffsettingAccount )
 LEFT OUTER JOIN i_glaccounttextincompanycode AS d ON  ( d~glaccount = A~OffsettingAccount
                                                     AND d~COMPANYCODE = A~companycode
                                                     AND d~Language = 'E' ) WHERE a~AccountingDocument = @wa_TAB-AccountingDocument  AND a~companycode = @wa_TAB-CompanyCode
 AND FiscalYear = @wa_TAB-FiscalYear AND a~FinancialAccountType = 'S' AND a~OffsettingAccount <> '' AND a~OffsettingAccount <> @glcodefrom INTO @data(glname).

 if glname-SupplierName is NOT INITIAL .
 WA_TAB-glaccountlongname = glname-SupplierName .
 elseif glname-CustomerName is NOT INITIAL .
  WA_TAB-glaccountlongname = glname-CustomerName .
 elseif glname-glaccountlongname is NOT INITIAL .
  WA_TAB-glaccountlongname = glname-glaccountlongname  .
 ENDIF.

 if WA_TAB-DebitCreditCode = 'S' AND WA_TAB-AmountInCompanyCodeCurrency > 0.
 DATA(PAISA) = WA_TAB-AmountInCompanyCodeCurrency  .
 ELSEIF

 WA_TAB-DebitCreditCode = 'H' OR WA_TAB-AmountInCompanyCodeCurrency < 0.
 DATA(PAISA1) = WA_TAB-AmountInCompanyCodeCurrency .
 ENDIF.


SUM  = SUM + PAISA + PAISA1.
SUM1 = SUM + OPENING .

    IF sum1 < 0 .
    sum2  =  sum1 * -1 .
    ELSE.
    sum2  = sum1 .
    ENDIF.

 IF PAISA1 < 0 .
 DATA(CRADIT) = PAISA1 * -1.
 ELSE.
 CRADIT = PAISA1.
 ENDIF.


   DATA(lv_xml1) =    |<LopTab>| &&
         |<Row1>| &&
         |<docno>{ WA_TAB-accountingdocument }</docno>| &&
         |<docdate>{ WA_TAB-postingdate }</docdate>| &&
         |<particulars>{ WA_TAB-glaccountlongname }</particulars>| &&
         |<doctype>{ WA_TAB-accountingdocumenttype  }</doctype>| &&
         |<debitamt>{ PAISA }</debitamt>| &&
         |<creditamt>{ CRADIT }</creditamt>| &&
         |<Balance>{ SUM2 }</Balance>| &&
      |</Row1>| &&
   |</LopTab>| .

  CONCATENATE xsml LV_XML1  INTO XSML.
  CLEar: paisa , paisa1,glname,WA_TAB,PAISA,CRADIT.
  ENDLOOP.
   DATA(lv_xml2) =   |<Subform3>| &&
      |<Table3>| &&
         |<Row1>| &&
            |<closingbl>{ CLOSING }</closingbl>| &&
         |</Row1>| &&
      |</Table3>| &&
   |</Subform3>| &&
   |<Subform2>| &&
      |<SIGN></SIGN>| &&
      |<preparedby></preparedby>| &&
   |</Subform2>| &&
|</form1>|.

   CONCATENATE LV_xml XSML lv_xml2 INTO LV_XML.



    DATA template TYPE string .
    template =  'LEDGERSTATEMENTPRINT/LEDERSTATEMENTPRINT' .


      CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = LV_XML
         template = template
       RECEIVING
         result   = result12 ).

  ENDMETHOD.
ENDCLASS.
