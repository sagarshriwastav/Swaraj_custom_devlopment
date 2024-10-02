CLASS yaccount_statement_vendor_cl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
    TYPES : BEGIN OF ty_final,
              document                     TYPE i_operationalacctgdocitem-accountingdocument,
              postingdate                  TYPE i_operationalacctgdocitem-postingdate,
              accountingdocumenttype       TYPE i_operationalacctgdocitem-accountingdocumenttype,
              companycode                  TYPE i_operationalacctgdocitem-companycode,
              fiscalyear                   TYPE i_operationalacctgdocitem-fiscalyear,
              material                     TYPE i_operationalacctgdocitem-material,
              FINANCIALACCOUNTTYPE         TYPE i_operationalacctgdocitem-FinancialAccountType,
              quantity                     TYPE i_operationalacctgdocitem-quantity,
              baseunit                     TYPE i_operationalacctgdocitem-baseunit,
              amountintransactioncurrency  TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              CashDiscountAmount           TYPE i_operationalacctgdocitem-CashDiscountAmount,
              transactiontypedetermination TYPE i_operationalacctgdocitem-transactiontypedetermination,
              debitcreditcode              TYPE i_operationalacctgdocitem-debitcreditcode,
              joi                          TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              joc                          TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              jos                          TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              jtc                          TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              wth                          TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              deb_amt                      TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              cre_amt                      TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              closing_bal                  TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              taxableamt                   TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              taxableamtc                  TYPE i_operationalacctgdocitem-amountintransactioncurrency,
              remarks                      TYPE i_operationalacctgdocitem-documentitemtext,
              businessplace                TYPE i_operationalacctgdocitem-businessplace,
            END OF ty_final.

    CLASS-DATA : BEGIN OF w_head,
                   opening_bal   TYPE i_operationalacctgdocitem-amountintransactioncurrency,
                   closing_bal   TYPE i_operationalacctgdocitem-amountintransactioncurrency,
                   value         TYPE i_operationalacctgdocitem-customer,
                   cusvssupp(25) TYPE c,
                   tds(25)       TYPE c,
                 END OF w_head.

    CLASS-DATA : BEGIN OF wa_add1,
                   name               TYPE i_supplier-supplierfullname,
                   taxnumber3         TYPE i_supplier-taxnumber3,
                   customer           TYPE i_supplier-customer,
                   telephonenumber1   TYPE i_supplier-phonenumber1,
                   organizationname1  TYPE i_address_2-organizationname1,
                   organizationname2  TYPE i_address_2-organizationname2,
                   organizationname3  TYPE i_address_2-organizationname3,
                   housenumber        TYPE i_address_2-housenumber,
                   streetname         TYPE i_address_2-streetname,
                   streetprefixname1  TYPE i_address_2-streetprefixname1,
                   streetprefixname2  TYPE i_address_2-streetprefixname2,
                   streetsuffixname1  TYPE i_address_2-streetsuffixname1,
                   streetsuffixname2  TYPE i_address_2-streetsuffixname2,
                   districtname       TYPE i_address_2-districtname,
                   cityname           TYPE i_address_2-cityname,
                   addresssearchterm1 TYPE i_address_2-addresssearchterm1,
                   postalcode         TYPE i_supplier-postalcode,
                   regionname         TYPE i_regiontext-regionname,
                 END OF wa_add1.

    CLASS-DATA :BEGIN OF wa_add,
                  var1(80)  TYPE c,
                  var2(80)  TYPE c,
                  var3(80)  TYPE c,
                  var4(80)  TYPE c,
                  var5(80)  TYPE c,
                  var6(80)  TYPE c,
                  var7(80)  TYPE c,
                  var8(80)  TYPE c,
                  var9(80)  TYPE c,
                  var10(80) TYPE c,
                  var11(80) TYPE c,
                  var12(80) TYPE c,
                  var13(80) TYPE c,
                  var14(80) TYPE c,
                  var15(80) TYPE c,
                END OF wa_add.

    CLASS-DATA : it_final TYPE TABLE OF ty_final,
                 wa_final TYPE ty_final.
    CLASS-DATA : access_token TYPE string .
    CLASS-DATA : xml_file TYPE string .


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
        RAISING   cx_static_check ,

      read_posts
         IMPORTING VALUE(companycode)     TYPE string
                  VALUE(correspondence)   TYPE string
                  VALUE(accounttype)      TYPE string
                  VALUE(customer)         TYPE string
                  VALUE(lastdate)         TYPE string
                  VALUE(currentdate)      TYPE string
                  VALUE(profitcenter)     TYPE CHAR10
                  VALUE(confirmletterbox) TYPE string
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
 "   CONSTANTS  lc_template_name TYPE string VALUE 'ZFICUSTANDSUPPSTATEMENT/ZFICUSTANDSUPPSTATEMENT'.
    CONSTANTS  lc_template_name TYPE string VALUE 'ACCOUNTSTATEMENT_NEW7/ACCOUNTSTATEMENT_NEW7'..
ENDCLASS.



CLASS YACCOUNT_STATEMENT_VENDOR_CL IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD .


  METHOD read_posts .

*    DATA REC(2) TYPE C.
    DATA REC TYPE string.
    DATA xsml   TYPE string.
    DATA date2  TYPE string.
    DATA gv1    TYPE string .
    DATA gv2    TYPE string .
    DATA gv3    TYPE string .
    DATA CLOSE_BAL TYPE   i_operationalacctgdocitem-AmountInCompanyCodeCurrency .

    gv3 = currentdate+6(4)  .
    gv2 = currentdate+3(2)  .
    gv1 = currentdate+0(2)  .

    CONCATENATE gv3 gv2 gv1   INTO date2.

    DATA date3 TYPE string.
    DATA gv4 TYPE string .
    DATA gv5 TYPE string .
    DATA gv6 TYPE string .

    gv6 = lastdate+6(4)  .
    gv5 = lastdate+3(2)  .
    gv4 = lastdate+0(2)  .

    CONCATENATE gv6 gv5 gv4  INTO date3.

    DATA VAR TYPE zchar10 .
       VAR   = |{ customer ALPHA = IN }|.
    customer = VAR.


      SELECT SINGLE a~taxnumber3,
                    a~customer,
                    b~organizationname1,
                    b~organizationname2,
                    b~organizationname3,
                    b~housenumber,
                    b~streetname,
                    b~streetprefixname1,
                    b~streetprefixname2,
                    b~streetsuffixname1,
                    b~streetsuffixname2,
                    b~districtname,
                    b~cityname,
                    b~addresssearchterm1,
                    b~postalcode,
                    c~regionname
                    FROM i_supplier AS a
                    INNER JOIN i_address_2 WITH PRIVILEGED ACCESS AS b ON ( b~addressid =  a~addressid )
                    LEFT JOIN i_regiontext AS c ON ( c~region = a~region AND c~language = 'E' AND c~country = 'IN ')
                    WHERE a~supplier = @customer  INTO CORRESPONDING FIELDS OF @wa_add1.

      wa_add-var1 = wa_add1-organizationname1.
      wa_add-var2 = wa_add1-organizationname2.
      wa_add-var3 = wa_add1-organizationname3.
      DATA(coname) = zseparate_address=>separate( CHANGING var = wa_add ).

      wa_add-var1 = wa_add1-housenumber.
      wa_add-var2 = wa_add1-streetname.
      wa_add-var3 = wa_add1-streetprefixname1.
      wa_add-var4 = wa_add1-streetprefixname2.
      wa_add-var5 = wa_add1-streetsuffixname1.
      wa_add-var6 = wa_add1-streetsuffixname2.
      DATA(streetno) = zseparate_address=>separate( CHANGING var = wa_add ).

      wa_add-var1 = wa_add1-cityname.
*    wa_add-var2 = wa_add1-districtname.
      wa_add-var3 = wa_add1-postalcode.
      DATA(city) = zseparate_address=>separate( CHANGING var = wa_add ).

  IF  Profitcenter = '' .

    SELECT a~billingdocument,
           a~accountingdocument,
           a~postingdate,
           a~accountingdocumenttype,
           a~companycode,
           a~fiscalyear,
           a~material,
           A~CLEARINGJOURNALENTRY ,
           a~FINANCIALACCOUNTTYPE,
           sum( a~AmountInCompanyCodeCurrency ) AS amountintransactioncurrency,
           sum( a~CashDiscountAmount ) AS CashDiscountAmount,
           a~debitcreditcode,
           a~baseunit
           FROM i_operationalacctgdocitem AS a
           INNER JOIN I_JournalEntry  as c ON (  c~AccountingDocument = a~AccountingDocument
                                                    AND c~CompanyCode = a~CompanyCode
                                                    AND c~FiscalYear = a~FiscalYear
                                                    AND c~IsReversal <> 'X' AND c~IsReversed <> 'X')
           WHERE a~companycode = @companycode
             AND ( a~supplier     = @customer )
             AND a~financialaccounttype = 'K'
             AND a~SPECIALGLCODE <> 'F'
             and A~PostingDate GE @date3 AND A~PostingDate LE @date2
*             AND a~AccountingDocumentType <> 'AB'
             GROUP BY
           a~billingdocument,
           a~accountingdocument,
           a~postingdate,
           a~accountingdocumenttype,
           a~companycode,
           a~fiscalyear,
           a~material,
           A~CLEARINGJOURNALENTRY ,
           a~debitcreditcode,
           a~baseunit,
           a~FINANCIALACCOUNTTYPE
             INTO TABLE @DATA(it_tab) .

     data gst1 TYPE string .
     data cin1 TYPE string .
     data pan1 TYPE string .
     data Register1 TYPE string .
     data Register2 TYPE string .
     data Register3 TYPE string .

     IF companycode   =  '1000' .

     gst1  = '08AAHCS2781A1ZH'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Reg. Off. F-483 To F-487 RIICO Growth Centre' .
     Register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
     cin1 = 'L18101RJ2003PLC018359'.

     elseif companycode   =  '2000' .

     gst1  = '08AABCM5293P1ZT'.
     pan1  = 'AABCM5293P'.
     Register1 = 'MODWAY SUITING PVT. LIMITED'.
     Register2 = 'Reg. Off. Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
     Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
     cin1 = 'U18108RJ1986PTC003788'.

     ENDIF.
 ELSE.

  IF Profitcenter  = '0000110000'.
    gst1  = '23AAHCS2781A1ZP'.
    pan1  = 'AAHCS2781A'.
    Register1 = 'SWARAJ SUITING LIMITED'.
    Register2 = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
    Register3 = ' Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
    cin1 = 'L18101RJ2003PLC018359'.
    elseif Profitcenter  = '0000120000'.
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
     Register3 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Profitcenter  = '0000130000'.
     gst1  = '08AAHCS2781A1ZH'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
     Register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Profitcenter  = '0000131000'.
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
     Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Profitcenter  = '0000140000'.
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Process House-I, B-24 To B-41 Jhanjharwada Industrial Area' .
     Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Profitcenter  = '0000210000'.
     gst1  = '08AABCM5293P1ZT'.
     pan1  = 'AABCM5293P'.
     Register1 = 'MODWAY SUITING PVT. LIMITED'.
     Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
     Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
     cin1 = 'U18108RJ1986PTC003788'.
    elseif Profitcenter  = '0000220000'.
     gst1  = '23AABCM5293P1Z1'.
     pan1  = 'AABCM5293P'.
     Register1 = 'MODWAY SUITING PVT. LIMITED'.
     Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
     Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'U18108RJ1986PTC003788'.
    ENDIF.

       SELECT
           a~billingdocument,
           a~accountingdocument,
           a~postingdate,
           a~accountingdocumenttype,
           a~companycode,
           a~fiscalyear,
           a~material,
           A~CLEARINGJOURNALENTRY ,
           a~FINANCIALACCOUNTTYPE,
           sum( a~AmountInCompanyCodeCurrency ) AS amountintransactioncurrency,
           sum( a~CashDiscountAmount ) AS CashDiscountAmount,
           a~debitcreditcode,
           a~baseunit
           FROM i_operationalacctgdocitem AS A
             INNER JOIN ZJOURNALENTRY_ITEM AS B ON (  B~AccountingDocument = a~AccountingDocument
                                                    AND B~CompanyCode = a~CompanyCode
                                                    AND B~FiscalYear = a~FiscalYear )
            INNER JOIN I_JournalEntry  as c ON (  c~AccountingDocument = a~AccountingDocument
                                                    AND c~CompanyCode = a~CompanyCode
                                                    AND c~FiscalYear = a~FiscalYear
                                                    AND c~IsReversal <> 'X' AND c~IsReversed <> 'X')
             WHERE a~companycode = @companycode
             AND   a~supplier     = @customer
             AND   a~financialaccounttype = 'K'
             AND a~SPECIALGLCODE <> 'F'
             and   a~PostingDate GE @date3 AND A~PostingDate LE @date2
*             AND   a~AccountingDocumentType <> 'AB'
             AND   b~ProfitCenter = @profitcenter
           GROUP BY
           a~billingdocument,
           a~accountingdocument,
           a~postingdate,
           a~accountingdocumenttype,
           a~companycode,
           a~fiscalyear,
           a~material,
           a~debitcreditcode,
           a~baseunit,
           A~CLEARINGJOURNALENTRY ,
           a~FINANCIALACCOUNTTYPE

     INTO table @it_tab.

 ENDIF.

    SORT it_tab BY billingdocument accountingdocument  .
*    DELETE ADJACENT DUPLICATES FROM it_tab COMPARING billingdocument accountingdocument .

    IF it_tab IS NOT INITIAL.
      SELECT material,
             quantity,
             baseunit,
             billingdocument ,
             a~accountingdocument,
             accountingdocumentitem,
             AmountInCompanyCodeCurrency as amountintransactioncurrency,
             CashDiscountAmount,
             transactiontypedetermination,
             debitcreditcode,
             withholdingtaxamount,
             costcenter,
             a~accountingdocumenttype,
             HouseBank,
             glaccount,
             SUPPLIER
             FROM i_operationalacctgdocitem as a
             INNER JOIN I_JournalEntry  as c ON (  c~AccountingDocument = a~AccountingDocument
                                                    AND c~CompanyCode = a~CompanyCode
                                                    AND c~FiscalYear = a~FiscalYear
                                                    AND c~IsReversal <> 'X' AND c~IsReversed <> 'X')
             FOR ALL ENTRIES IN @it_tab
             WHERE a~companycode          = @it_tab-companycode
               AND a~fiscalyear           = @it_tab-fiscalyear
               AND a~accountingdocument   = @it_tab-accountingdocument
                and a~PostingDate GE @date3 AND a~PostingDate LE @date2
               INTO TABLE @DATA(it_tab2) .
    ENDIF.

    SELECT SUM( a~AmountInCompanyCodeCurrency )
    FROM i_operationalacctgdocitem as a
    INNER JOIN I_JournalEntry  as c ON (  c~AccountingDocument = a~AccountingDocument
                                                    AND c~CompanyCode = a~CompanyCode
                                                    AND c~FiscalYear = a~FiscalYear
                                                    AND c~IsReversal <> 'X' AND c~IsReversed <> 'X')
           WHERE a~companycode = @companycode AND ( a~supplier = @customer OR a~customer = @customer )
           AND   a~postingdate LT @date3
           AND   a~AccountingDocumentType NE 'GE' AND  a~AccountingDocumentType  NE 'WE' AND a~SpecialGLCode <> 'F'
           INTO @w_head-opening_bal.

    SORT it_tab  BY postingdate accountingdocument billingdocument.

    DATA(opening) = w_head-opening_bal.


        SELECT SINGLE * FROM i_supplier as a
   left outer  join I_SuplrBankDetailsByIntId as b on ( b~Supplier = a~Supplier  )
    left outer  join  I_Bank_2 as f on ( f~BankInternalID = b~Bank  )  WHERE a~Supplier = @customer  INTO @DATA(supplier).
   SELECT SINGLE * FROM ZSUPPLIER_DETAILS where Supplier = @customer  into @DATA(email).

"""""""""""""""""""""""""""""""""""""""""""""""Address"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    DATA(lv_xml) =
     |<form1>| &&
   |<plantname>{ Register1 }</plantname>| &&
   |<address1>{ Register2 }</address1>| &&
   |<address2>{ Register3 }</address2>| &&
   |<address3></address3>| &&
   |<CINNO>{ cin1 }</CINNO>| &&
   |<GSTIN>{ gst1 }</GSTIN>| &&
   |<PAN>{ pan1 }</PAN>| &&
   |<LeftSide>| &&
   |<partyno>{ supplier-A-SupplierName }</partyno>| &&
    |<ccode>({ customer })</ccode>| &&
   |<partyno2>{ email-StreetPrefixName1 }</partyno2>| &&
   |<partyno3>{ email-StreetPrefixName2 }</partyno3>| &&
   |<partyadd>{ supplier-A-CityName }-{ supplier-A-PostalCode }</partyadd>| &&
   |<partyadd1>{ supplier-A-TaxNumber3 }</partyadd1>| &&
   |<PHNNO>{ email-PhoneNumber1 }</PHNNO>| &&
   |<EMAIL>{ email-EmailAddress }</EMAIL>| &&
   |<Subform7/>| &&
   |</LeftSide>| &&
   |<RightSide>| &&
      |<date></date>| &&
      |<openingbl>{ OPENING }</openingbl>| &&
      |<TransporterName></TransporterName>| &&
      |<FromDate>{ lastdate }</FromDate>| &&
      |<ToDate>{ currentdate }</ToDate>| &&
      |<Page>| &&
      |<HaderData>| &&
      |<RightSide>| &&
      |<StationNo></StationNo>| &&
      |</RightSide>| &&
      |</HaderData>| &&
      |</Page>| &&
      |</RightSide>| &&
      |<BankDetail>| &&
      |<BankName>{ supplier-F-BankName }</BankName>| &&
      |<AccountNo>{ supplier-B-BankAccount }</AccountNo>| &&
      |<IFSC>{ supplier-B-Bank }</IFSC>| &&
      |</BankDetail>| &&
      |<chk_mark>{ confirmletterbox }</chk_mark>| .
*                |<form1>| &&
*                |<Page1>| &&
*                |<Address>| &&
*                |<CompanyName>{ Register1 }</CompanyName>| &&
*                |<CompanyAddress>{ Register2 }</CompanyAddress>| &&
*                |<CompanyAddress1>{ Register3 }</CompanyAddress1>| &&
*                |</Address>| &&
*                |<Detail>| &&
*                |<CusAndSupp>{ 'Supplier' }</CusAndSupp>| &&
*                |<CustAndSuppNo>{ customer }</CustAndSuppNo>| &&
*                |<POSTINGDATE>{ lastdate }</POSTINGDATE>| &&
*                |<POSTINGDATETO>{ currentdate }</POSTINGDATETO>| &&
*                |<OpeningBalance>{ w_head-opening_bal }</OpeningBalance>| &&
*                |</Detail>| &&
*                |<Add>| &&
*                |<name>{ coname }</name>| &&
*                |<Add>{ streetno },{ city }</Add>| &&
*                |<GStin>{ wa_add1-taxnumber3 }</GStin>| &&
*                |</Add>| &&
*                |<tableSubFo>| &&
*                |<Table1>| &&
*                |<Row1>|  &&
*                |<tdsHad>{ 'TDS' }</tdsHad>|  &&
*                |</Row1>| .
    LOOP AT it_tab INTO DATA(wa_tab).

      IF  wa_tab-billingdocument IS NOT INITIAL.
        wa_final-document    = wa_tab-billingdocument.
      ELSE.
        wa_final-document = wa_tab-accountingdocument.
      ENDIF.
      wa_final-postingdate                 = wa_tab-postingdate.
      wa_final-accountingdocumenttype      = wa_tab-accountingdocumenttype.
      wa_final-amountintransactioncurrency = wa_tab-amountintransactioncurrency.
      wa_final-CashDiscountAmount           =  wa_tab-CashDiscountAmount.
      wa_final-debitcreditcode             = wa_tab-debitcreditcode.
       wa_final-fiscalyear             = wa_tab-FiscalYear.
        wa_final-companycode             = wa_tab-CompanyCode.
        wa_final-financialaccounttype  = wa_tab-FinancialAccountType.

    if wa_final-DebitCreditCode = 'S' AND wa_final-amountintransactioncurrency > 0.
     wa_final-deb_amt =  wa_tab-amountintransactioncurrency.
     ELSEIF
     wa_final-DebitCreditCode = 'H' OR wa_final-amountintransactioncurrency < 0 .
      wa_final-cre_amt =  wa_tab-amountintransactioncurrency.

     ENDIF.
********************
*if wa_final-accountingdocumenttype = 'KZ'.
*if wa_final-DebitCreditCode = 'H' and wa_final-financialaccounttype = 'K'.
*  wa_final-cre_amt = ''.
*ENDIF.
*ENDIF.
*************************


      SELECT SINGLE a~baseunit ,
                    b~productdescription
                             FROM i_operationalacctgdocitem AS a
                             INNER JOIN I_JournalEntry  as c ON (  c~AccountingDocument = a~AccountingDocument
                                                    AND c~CompanyCode = a~CompanyCode
                                                    AND c~FiscalYear = a~FiscalYear
                                                    AND c~IsReversal <> 'X' AND c~IsReversed <> 'X')
                             INNER JOIN i_productdescription AS b ON ( b~product = a~product AND b~language = 'E' )
                             WHERE a~accountingdocument = @wa_tab-accountingdocument
                             AND a~material <> ''
                             INTO (@wa_final-baseunit,@wa_final-material) .

      IF wa_final-material IS INITIAL.

        SELECT SINGLE a~glaccount ,
                      b~glaccountlongname
                               FROM i_operationalacctgdocitem AS a
                                INNER JOIN I_JournalEntry  as c ON (  c~AccountingDocument = a~AccountingDocument
                                                    AND c~CompanyCode = a~CompanyCode
                                                    AND c~FiscalYear = a~FiscalYear
                                                    AND c~IsReversal <> 'X' AND c~IsReversed <> 'X')
                               INNER JOIN i_glaccounttext  AS b ON ( b~glaccount = a~glaccount AND b~language = 'E' )
                               WHERE a~accountingdocument = @wa_tab-accountingdocument
                               AND a~glaccount <> ''
                               INTO @DATA(gl_desc) .
        wa_final-material = gl_desc-glaccountlongname.

      ENDIF.

      LOOP AT it_tab2 INTO DATA(wa_tab2) WHERE accountingdocument = wa_tab-accountingdocument  .
        wa_final-quantity = wa_final-quantity + wa_tab2-quantity.
        CASE wa_tab2-transactiontypedetermination.
          WHEN  'JOI' OR 'JII' OR 'JIM'.
            wa_final-joi = wa_final-joi + wa_tab2-amountintransactioncurrency.
          WHEN  'JOC' OR 'JIC'.
            wa_final-joc = wa_final-joc + wa_tab2-amountintransactioncurrency.
          WHEN  'JOS' OR 'JIS'.
            wa_final-jos = wa_final-jos + wa_tab2-amountintransactioncurrency.
          WHEN  'JTC' .
            wa_final-jtc = wa_final-jtc + wa_tab2-amountintransactioncurrency.
          WHEN  'WTH' OR 'WIT'.
            wa_final-wth = wa_final-wth + wa_tab2-amountintransactioncurrency.
        ENDCASE.
        if WA_TAB-AccountingDocumentType = 'KZ' AND ( wa_tab2-HouseBank <> '' OR wa_tab2-GLAccount = '2200001800' or wa_tab2-GLAccount = '2200001900' or wa_tab2-GLAccount = '2200002000' or wa_tab2-GLAccount = '2200002100'
        OR  wa_tab2-SUPPLIER = '0001100372' OR wa_tab2-SUPPLIER = '0001100377' OR wa_tab2-SUPPLIER = '0001100776' OR wa_tab2-SUPPLIER = '0001100373' ).
         wa_final-taxableamt = wa_final-taxableamt + wa_tab2-amountintransactioncurrency.
        ELSE.

        IF  wa_tab2-TransactionTypeDetermination =   'SKE' AND WA_TAB-AccountingDocumentType <> 'KZ'.
          wa_final-taxableamt = wa_final-taxableamt + wa_tab2-amountintransactioncurrency.
        ELSEIF
        wa_tab2-TransactionTypeDetermination =  'WRX' OR wa_tab2-TransactionTypeDetermination =  'AGD' OR wa_tab2-TransactionTypeDetermination =  'BSX'
           OR wa_tab2-TransactionTypeDetermination =  'PRD' OR wa_tab2-TransactionTypeDetermination =  'RKA' OR wa_tab2-TransactionTypeDetermination =  'ANL'
           OR  wa_tab2-TransactionTypeDetermination =  'PK2'  OR wa_tab2-TransactionTypeDetermination =  'EGK'  OR wa_tab2-TransactionTypeDetermination =  'FR3'.
           wa_final-taxableamt = wa_final-taxableamt + wa_tab2-amountintransactioncurrency.
          ENDIF.
          ENDIF.
      ENDLOOP.

      wa_final-closing_bal =  opening + wa_final-cre_amt + wa_final-deb_amt .
      w_head-closing_bal =  opening + wa_final-cre_amt + wa_final-deb_amt .
      opening =  opening + wa_final-cre_amt + wa_final-deb_amt .
      IF WA_TAB-AccountingDocumentType = 'KZ' .
      wa_final-cashdiscountamount = wa_final-cashdiscountamount + ( wa_final-joc + wa_final-jos + wa_final-joi ).
      ENDIF.
      APPEND wa_final TO it_final.
      CLEAR wa_final.

    ENDLOOP.

  CLEAR REC.
  LOOP AT it_final INTO wa_final.

    rec = rec + 1.
    DATA(COUNT) = lines( IT_FINAL ).


       SELECT SINGLE * FROM i_journalentry
  where AccountingDocument = @wa_final-document AND CompanyCode = @wa_final-CompanyCode
  AND FiscalYear = @wa_final-FiscalYear  AND IsReversal <> 'X' AND IsReversed <> 'X' INTO @DATA(tab2).

     SELECT SINGLE GLAccount FROM i_operationalacctgdocitem as a
      INNER JOIN I_JournalEntry  as c ON (  c~AccountingDocument = a~AccountingDocument
                                                    AND c~CompanyCode = a~CompanyCode
                                                    AND c~FiscalYear = a~FiscalYear
                                                    AND c~IsReversal <> 'X' AND c~IsReversed <> 'X')
     where  a~FiscalYear = @wa_final-FiscalYear AND a~CompanyCode = @wa_final-CompanyCode AND a~AccountingDocument = @wa_final-document AND a~AccountingDocumentType = @wa_final-AccountingDocumentType
     AND a~GLAccount NE '2500001000' AND a~GLAccount NE '2500002000' AND a~GLAccount NE '2500003000' AND a~GLAccount NE '2500004000'
     AND a~GLAccount NE '2700001010' AND a~GLAccount NE '2700001020' AND a~GLAccount NE '2700001030' AND a~GLAccount NE '2700001040'
     AND a~GLAccount NE '2700001050' AND a~GLAccount NE '2700001060' AND a~GLAccount NE '2700001070'
     AND a~GLAccount NE '2700001080' AND a~GLAccount NE '2700001090' AND a~GLAccount NE '2700001100'
     AND a~GLAccount NE '2700002000' AND a~GLAccount NE '2700004000' AND a~GLAccount NE '2700004010' AND a~GLAccount NE '2700004020' AND a~GLAccount NE '2700004030'
     AND a~GLAccount NE '2700004500' AND a~GLAccount NE '2700004510' AND a~GLAccount NE '2700004520' AND a~GLAccount NE '3500001410'
     AND a~AccountingDocumentItemType <> 'T' INTO @DATA(GL).

 if GL is INITIAL .
    SELECT SINGLE supplier as GLAccount FROM i_operationalacctgdocitem as a
     INNER JOIN I_JournalEntry  as c ON (  c~AccountingDocument = a~AccountingDocument
                                                    AND c~CompanyCode = a~CompanyCode
                                                    AND c~FiscalYear = a~FiscalYear
                                                    AND c~IsReversal <> 'X' AND c~IsReversed <> 'X')
    where  a~FiscalYear = @wa_final-FiscalYear AND a~CompanyCode = @wa_final-CompanyCode
    AND a~AccountingDocument = @wa_final-document  AND a~FinancialAccountType = 'K'  AND a~Supplier <> @customer INTO @GL.
endif.

  SELECT SINGLE GLAccountLongName FROM I_GLAccountText
  WHERE GLAccount = @GL AND Language = 'E'
  into @DATA(tab7).

if tab7 is INITIAL .
    SELECT SINGLE suppliername as GLAccountLongName FROM i_supplier
  WHERE supplier = @GL into @tab7.
  endif.

  DATA DESC TYPE STRING .
 if wa_final-AccountingDocumentType = 'RE' OR wa_final-AccountingDocumentType = 'UE'  .

      DESC = 'PURCHASE'.

 ELSEif wa_final-AccountingDocumentType = 'KC'.
      DESC = 'CREDIT NOTE'.

 ELSEif wa_final-AccountingDocumentType = 'KG' OR wa_final-AccountingDocumentType = 'ZA' OR wa_final-AccountingDocumentType = 'RK'.
      DESC = 'DEBIT NOTE'.

 ELSE.
      DESC = tab7.

 ENDIF.

********************
*if wa_final-accountingdocumenttype = 'KZ'.
*if wa_final-DebitCreditCode = 'H' and wa_final-financialaccounttype = 'K'.
*    wa_final-deb_amt  =  wa_final-taxableamt.
*ENDIF.
*ENDIF.
*************************




      lv_xml = lv_xml &&
*                  |<Item>| &&
*                  |<DocumentNo> { tab2-DocumentReferenceID } </DocumentNo>| &&
*                  |<PostingDate>{ wa_final-postingdate+6(2) }.{ wa_final-postingdate+4(2) }.{ wa_final-postingdate+0(4) }</PostingDate>| &&
*                  |<Documenttype>{ wa_final-accountingdocumenttype }</Documenttype>| &&
*                  |<Material>{ DESC }</Material>| &&
*                  |<Qty>{ wa_final-quantity }</Qty>| &&
*                  |<Unit>{ wa_final-baseunit }</Unit>| &&
**                  |<Taxablevalue>{ wa_final-taxableamt }</Taxablevalue>| &&
*                  |<Taxablevalue>{ wa_final-taxableamt }</Taxablevalue>| &&
*                  |<CDRDCLAIM>{ wa_final-CashDiscountAmount }</CDRDCLAIM>| &&
*                  |<IGST>{ wa_final-joi }</IGST>| &&
*                  |<CGST>{ wa_final-joc }</CGST>| &&
*                  |<SGST>{ wa_final-jos }</SGST>| &&
*                  |<TCS>{ wa_final-jtc }</TCS>| &&
*                  |<TDS>{ wa_final-wth }</TDS>| &&
*                  |<DebitAmount>{ wa_final-deb_amt }</DebitAmount>| &&
*                  |<CreditAmount>{ wa_final-cre_amt }</CreditAmount>| &&
*                  |<ClosingBalance>{ wa_final-closing_bal }</ClosingBalance>| &&
*                  |<BusinessPlace>{ wa_final-businessplace }</BusinessPlace>| &&
*                  |</Item>|.

                   |<LopTab>| &&
        |<Row1>| &&
         |<docno>{ Tab2-DocumentReferenceID }</docno>| &&
         |<docdate>{ wa_final-postingdate+6(2) }.{ wa_final-postingdate+4(2) }.{ wa_final-postingdate+0(4) }</docdate>| &&
         |<particulars>{ DESC  }</particulars>| &&
         |<doctype>{ wa_final-accountingdocumenttype }</doctype>| &&
         |<Value>{ wa_final-taxableamt }</Value>| &&
         |<cdrd>{ wa_final-CashDiscountAmount }</cdrd>| &&
         |<IGST>{ wa_final-joi }</IGST>| &&
         |<CGST>{ wa_final-joc }</CGST>| &&
         |<SGST>{ wa_final-jos }</SGST>| &&
         |<Tdsamt>{ wa_final-wth }</Tdsamt>| &&
         |<tcs></tcs>| &&
         |<debitamt>{ wa_final-deb_amt }</debitamt>| &&
         |<creditamt>{ wa_final-cre_amt }</creditamt>| &&
         |<Balance>{ wa_final-closing_bal }</Balance>| &&
      |</Row1>| &&
      |</LopTab>|.

   IF REC = COUNT.
    close_bal = wa_final-closing_bal.
    endif.

      CLEAR:GL,tab7,tab2,wa_final,DESC.
    ENDLOOP.

   DATA closingbl TYPE   i_operationalacctgdocitem-AmountInCompanyCodeCurrency .
    closingbl = close_bal.


    lv_xml = lv_xml &&
*        |</Table1>| &&
*        |</tableSubFo>| &&
*        |<ClosingBalance1>{ w_head-closing_bal }</ClosingBalance1>| &&
*        |</Page1>| &&
*        |</form1>| .

        |<Subform3>| &&
       |<Table3>| &&
          |<Row1>| &&
            |<closingbl>{ closingbl }</closingbl>| &&
         |</Row1>| &&
      |</Table3>| &&
      |</Subform3>| &&
      |<Subform2>| &&
      |<SIGN></SIGN>| &&
      |<preparedby></preparedby>| &&
      |</Subform2>| &&
      |</form1>| .

    DATA:res TYPE string.
    CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = lc_template_name
      RECEIVING
        result   = res ).
    CONCATENATE result12 res INTO result12.
    CONDENSE result12 NO-GAPS.
  ENDMETHOD.
ENDCLASS.
