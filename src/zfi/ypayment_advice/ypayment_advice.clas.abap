 CLASS ypayment_advice DEFINITION
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
        IMPORTING VALUE(fromdate) TYPE string
                  VALUE(todate)   TYPE string
                  VALUE(vendor)   TYPE string
                  VALUE(document) TYPE string
                  VALUE(comcode)  TYPE string
                  VALUE(remark)   TYPE string
                  VALUE(clearingdocument)   TYPE string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .
  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS  lc_template_name TYPE string VALUE 'PaymentAdvice/PaymentAdvice'.

ENDCLASS.



CLASS YPAYMENT_ADVICE IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.
    TRY.
    ENDTRY.
  ENDMETHOD.


  METHOD read_posts .

    DATA: where TYPE string.


    SELECT  * FROM i_operationalacctgdocitem as a
    INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' ) WHERE (where)
     AND a~accountingdocumenttype = 'KZ' and a~CompanyCode = @comcode AND a~accountingdocument = @document
      and a~FiscalYear = @fromdate  AND a~Supplier <> '0001100776' AND a~Supplier <> '0001100373' AND a~Supplier <> '0001100372'   INTO TABLE @DATA(tab1).


    READ TABLE tab1 WITH KEY a-transactiontypedetermination = 'WIT' TRANSPORTING NO FIELDS.
    IF sy-subrc IS INITIAL.
    DATA(wt) = VALUE #( tab1[ sy-tabix ]-a-amountinfunctionalcurrency ).
    ENDIF.

    DATA(lt_tab) = tab1[].
    DELETE lt_tab WHERE a-supplier IS INITIAL.
    IF line_exists( lt_tab[ 1 ] ).
    DATA(supamt) = VALUE #( lt_tab[ 1 ]-a-amountinfunctionalcurrency ).
    ENDIF.
    READ TABLE tab1 INTO DATA(WT_TAB1) INDEX 1 .

    SELECT SINGLE * FROM i_operationalacctgdocitem as a
    INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' )
     WHERE (where) AND ClearingJournalEntryFiscalYear = @todate
    AND a~accountingdocumenttype = 'KZ'
    AND a~accountingdocument = @document  and a~ClearingDate <> '00000000' INTO  @DATA(tab2).

    READ TABLE lt_tab INTO DATA(WT_TAB2) INDEX 1 .



******************************************NO CLEAR JOURNALENTRY supplier*****************************

    SELECT SINGLE * FROM i_operationalacctgdocitem WHERE (where)  AND accountingdocumenttype = 'KZ'
    AND accountingdocument = @WT_TAB2-a-AccountingDocument and FiscalYear = @WT_TAB2-a-FiscalYear
    AND supplier <> '' and FinancialAccountType = 'K' INTO  @DATA(tab3).

    SELECT SINGLE * FROM i_supplier WHERE supplier = @tab3-supplier  INTO @DATA(supplier).
     SELECT SINGLE RegionName from I_RegionText where Region = @supplier-Region AND Language = 'E'
           AND Country = 'IN' into @data(State).

     data(PAN)   = strlen( supplier-TaxNumber3 ).
     DATA(VAR)   = supplier-TaxNumber3+2(15).
     DATA(PANNO) = var+0(11).

***************************************CLEARINGJOURNALENTRY supplier******************************

    SELECT SINGLE * FROM i_supplier WHERE supplier = @WT_TAB2-a-supplier  INTO @supplier.
     SELECT SINGLE RegionName from I_RegionText where Region = @supplier-Region AND Language = 'E'
           AND Country = 'IN' into @State.
     PAN   = strlen( supplier-TaxNumber3 ).
     VAR   = supplier-TaxNumber3+2(15).
     PANNO = var+0(11).

    DATA xsml TYPE string.
    DATA amount TYPE string.

    template = 'PaymentAdvice/PaymentAdvice'  .

delete tab1 where a-Supplier is initial .

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 SELECT * FROM I_OperationalAcctgDocItem AS A
  INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' )  WHERE a~accountingdocument = @document and a~FiscalYear = @fromdate
                 AND a~CompanyCode = @comcode INTO TABLE @DATA(LV_PC).
delete lv_pc where a-ProfitCenter = ''.
  LOOP AT LV_PC INTO DATA(WA_PC).

 data plant1 type ychar4.
 data var2   type ychar6.
 data(g_l2) = strlen( WA_PC-a-ProfitCenter ).
 var2       = WA_PC-a-ProfitCenter+4(6).
 plant1     = var2+0(4).
ENDLOOP.

     data gst1 TYPE string .
     data cin1 TYPE string .
     data pan1 TYPE string .
     data Register1 TYPE string .
     data Register2 TYPE string .
     data Register3 TYPE string .

    IF Plant1  = '1100'.
    gst1  = '23AAHCS2781A1ZP'.
    pan1  = 'AAHCS2781A'.
    Register1 = 'SWARAJ SUITING LIMITED'.
    Register2 = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
    Register3 = ' Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
    cin1 = 'L18101RJ2003PLC018359'.
    elseif Plant1  = '1200'.
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
     Register3 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Plant1  = '1300'.
     gst1  = '08AAHCS2781A1ZH'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
     Register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Plant1  = '1310' .
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
     Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.

     elseif Plant1  = '1320' .
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
     Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.

    elseif Plant1  = '1400'.
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Process House-I, B-24 To B-41 Jhanjharwada Industrial Area' .
     Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Plant1  = '2100'.
     gst1  = '08AABCM5293P1ZT'.
     pan1  = 'AABCM5293P'.
     Register1 = 'MODWAY SUITING PVT. LIMITED'.
     Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
     Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
     cin1 = 'U18108RJ1986PTC003788'.
    elseif Plant1  = '2200'.
     gst1  = '23AABCM5293P1Z1'.
     pan1  = 'AABCM5293P'.
     Register1 = 'MODWAY SUITING PVT. LIMITED'.
     Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
     Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'U18108RJ1986PTC003788'.

     elseif Plant1  = ''.

     if comcode = '2000' .
     gst1  = '23AABCM5293P1Z1'.
     pan1  = 'AABCM5293P'.
     Register1 = 'MODWAY SUITING PVT. LIMITED'.
     cin1 = 'U18108RJ1986PTC003788'.
     elseif comcode = '1000' .
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     cin1 = 'L18101RJ2003PLC018359'.
     ENDIF.

    ENDIF.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    data amt TYPE P DECIMALS 2.
    data amount1 TYPE P DECIMALS 2.
    data AMT_WITH_TDS TYPE P DECIMALS 2.
    data AMT_WITH_TDS1 TYPE P DECIMALS 2.
    data settelbal TYPE P DECIMALS 2.

 READ TABLE tab1 INTO DATA(wa_tab1) INDEX 1 .

   SELECT SINGLE * FROM i_journalentry WHERE fiscalyear = @wa_tab1-a-fiscalyear AND  IsReversed <> 'X' AND IsReversal <> 'X'
                     AND accountingdocument = @wa_tab1-a-AccountingDocument AND CompanyCode = @wa_tab1-a-CompanyCode INTO @DATA(journalentry).

    SELECT SINGLE *   FROM i_operationalacctgdocitem as a
     INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' )
         WHERE ( a~Supplier = '0001100776' OR a~Supplier = '0001100373' OR a~Supplier = '0001100372' OR a~Supplier = '0001100126' )  AND
          a~AccountingDocument = @document and a~FiscalYear = @fromdate AND a~CompanyCode = @comcode INTO @DATA(TOTAL)  .

  IF sy-subrc <> 0 .
  IF  TOTAL IS INITIAL .

      SELECT SINGLE *   FROM i_operationalacctgdocitem as a
     INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' )
         WHERE HouseBank IS NOT INITIAL  AND
          a~AccountingDocument = @wa_tab1-a-AccountingDocument and a~FiscalYear = @fromdate AND a~CompanyCode = @comcode INTO @TOTAL  .

  IF sy-subrc <> 0 .
     SELECT SINGLE * FROM i_operationalacctgdocitem as a
      INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' ) WHERE (where)
              AND a~AccountingDocument = @document and a~FiscalYear = @fromdate AND a~CompanyCode = @comcode
              AND ( a~HouseBank <> '' OR ( a~DebitCreditCode = 'S' AND a~FinancialAccountType = 'K' ) ) INTO @TOTAL.
  ENDIF.

  ENDIF.
  ENDIF.


    SELECT SINGLE *  FROM i_housebankaccountlinkage
      WHERE  housebank = @TOTAL-a-HouseBank INTO @DATA(bank).

   SELECT SINGLE * FROM I_OutgoingCheck WHERE PaymentDocument = @document
        AND PaymentCompanyCode = @comcode AND FiscalYear = @fromdate INTO @DATA(CHQ_DATA).

    DATA(P) = -1.
    DATA(TOTAL1) =  TOTAL-a-AmountInCompanyCodeCurrency   .
    IF TOTAL1  <  0 .
    TOTAL1 = TOTAL1 * P .
    ELSE .
    TOTAL1 = TOTAL1.
    ENDIF.

    select single documentreferenceid from I_JournalEntry where fiscalyear = @wa_tab1-a-fiscalyear AND IsReversed <> 'X' AND IsReversal <> 'X'
    AND  accountingdocument = @document and CompanyCode = @comcode into @DATA(ref_id).


      DATA(lv_xml) =
   |<Form>| &&
   |<VoucherNo>{ document }</VoucherNo>| &&
   |<VoucherDate>{ TOTAL-a-PostingDate+6(2) }/{ TOTAL-a-PostingDate+4(2) }/{ TOTAL-a-PostingDate+0(4) }</VoucherDate>| &&
   |<RefNo>{ ref_id }</RefNo>| &&
   |<paymentdate>{ chq_data-ChequePaymentDate+6(2) }/{ chq_data-ChequePaymentDate+4(2) }/{ chq_data-ChequePaymentDate+0(4) }</paymentdate>| &&
   |<Amount>{ TOTAL1 }</Amount>| &&
   |<AccountNo>{ bank-bankaccount }</AccountNo>| &&
   |<BankName>{ bank-bankname }</BankName>| &&
   |<CHDDDate>{ chq_data-PaymentDocPrintDate+6(2) }/{ chq_data-PaymentDocPrintDate+4(2) }/{ chq_data-PaymentDocPrintDate+0(4) }</CHDDDate>| &&
   |<CHDDNo>{ chq_data-OutgoingCheque }</CHDDNo>| &&
   |<Address1>{ supplier-SupplierName }</Address1>| &&
   |<Address2>Ego ille</Address2>| &&
   |<Address3>Si manu vacuas</Address3>| &&
   |<City>{ supplier-CityName }</City>| &&
   |<GstNo>{ supplier-TaxNumber3 }</GstNo>| &&
   |<PanNo>{ PANNO }</PanNo>| &&
   |<State>{ State }</State>| .


  SORT tab1 ASCENDING BY a-AmountInCompanyCodeCurrency .

 LOOP AT tab1 INTO DATA(wa_tab2).

 IF wa_tab2-a-InvoiceReference  = '' OR ( wa_tab2-a-InvoiceReference  <> '' AND wa_tab2-a-PostingKey = '27' ).

    IF wa_tab2-a-InvoiceReference  = '' .
       SELECT SINGLE  * FROM i_operationalacctgdocitem as a
        INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' )  WHERE (where)
                    AND (  a~CompanyCode = @comcode and a~accountingdocumenttype NE 'KZ'
                    AND a~AccountingDocument = @wa_tab2-a-AccountingDocument and a~FiscalYear = @fromdate )
                    INTO  @DATA(tab) .
   ELSE.
    SELECT SINGLE  * FROM i_operationalacctgdocitem as a
     INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' ) WHERE (where)
                    AND ( A~CompanyCode = @comcode and A~accountingdocumenttype NE 'KZ'
                    AND A~InvoiceReference = @wa_tab2-a-InvoiceReference and A~FiscalYear = @fromdate )
                    INTO  @tab .
   ENDIF.

   ELSE.
     SELECT SINGLE  * FROM i_operationalacctgdocitem as a
      INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' ) WHERE (where)
                    AND (  A~CompanyCode = @comcode and ( A~accountingdocumenttype = 'KZ' OR A~accountingdocumenttype = 'AB' OR A~accountingdocumenttype = 'KG'
                    OR A~accountingdocumenttype = 'RK' )
                    AND A~InvoiceReference = @wa_tab2-a-InvoiceReference and A~FiscalYear = @fromdate )
                    INTO  @tab .
   ENDIF.

       SELECT SINGLE * FROM i_journalentry WHERE CompanyCode = @wa_tab2-a-CompanyCode AND  IsReversed <> 'X' AND IsReversal <> 'X' AND
          AccountingDocument = @wa_tab2-a-AccountingDocument  AND FiscalYear = @wa_tab2-A-FiscalYear  INTO @journalentry.


       SELECT SUM( AmountInCompanyCodeCurrency ) FROM i_operationalacctgdocitem  AS a
       INNER JOIN i_journalentry as b on ( b~AccountingDocument = a~AccountingDocument and b~CompanyCode = a~CompanyCode
                                         AND b~FiscalYear = a~FiscalYear AND  b~IsReversed <> 'X' AND b~IsReversal <> 'X' ) WHERE a~AccountingDocument NE @document
       AND a~InvoiceReference = @wa_tab2-a-AccountingDocument AND a~CompanyCode = @comcode AND a~AccountingDocumentType = 'KZ' AND a~FiscalYear = @wa_tab2-a-FiscalYear
        INTO @DATA(PA_AMT).

   IF tab-a-AmountInCompanyCodeCurrency < 0 OR wa_tab2-a-AccountingDocumentType = 'KZ' .

   IF  wa_tab2-a-AccountingDocumentType = 'KZ' .
   AMT_WITH_TDS = ( tab-a-AmountInCompanyCodeCurrency ) + ( tab-a-WithholdingTaxAmount ).
   AMT_WITH_TDS1 = ( tab-a-AmountInCompanyCodeCurrency * P ) + ( tab-a-WithholdingTaxAmount * P ).
   ELSEIF tab-a-AmountInCompanyCodeCurrency < 0 .
   AMT_WITH_TDS = ( tab-a-AmountInCompanyCodeCurrency * P ) + ( tab-a-WithholdingTaxAmount * P ).
   AMT_WITH_TDS1 = tab-a-AmountInCompanyCodeCurrency  +  tab-a-WithholdingTaxAmount .
   ENDIF.

   ELSE.
   AMT_WITH_TDS = ( tab-a-AmountInCompanyCodeCurrency  ) + ( tab-a-WithholdingTaxAmount  ).
   AMT_WITH_TDS1 = tab-a-AmountInCompanyCodeCurrency  +  tab-a-WithholdingTaxAmount .

   ENDIF.


    settelbal =  ( AMT_WITH_TDS1 - ( pa_amt * -1 ) + ( tab-a-WithholdingTaxAmount * -1 ) + (  TAB-a-CashDiscountAmount * - 1 ) )  .

    amount = amount + settelbal.

       IF settelbal < 0.
       settelbal = settelbal * P.
      ENDIF.

   IF amount < 0 .
   amount1  =  amount * -1 .
   ELSE.
   amount1 =  amount1.
   ENDIF.

 IF  wa_tab2-a-AccountingDocumentType = 'ZA' OR wa_tab2-a-AccountingDocumentType = 'RK' OR wa_tab2-a-AccountingDocumentType = 'KG'.
 settelbal =  -1 * settelbal .
 ENDIF.


   DATA(lv_xml2) =
       |<hdrLineItems>| &&
      |<docno>{ journalentry-documentreferenceid }</docno>| &&
      |<docdate>{ journalentry-DocumentDate+6(2) }/{ journalentry-DocumentDate+4(2) }/{ journalentry-DocumentDate+0(4) }</docdate>| &&
      |<amount>{ AMT_WITH_TDS }</amount>| &&
      |<tdsper>{ pa_amt }</tdsper>| &&
      |<tdsamt>{ tab-a-WithholdingTaxAmount * P }</tdsamt>| &&
      |<CDRD>{ TAB-a-CashDiscountAmount * P }</CDRD>| &&
      |<settelbal>{  settelbal }</settelbal>| &&
   |</hdrLineItems>| .


      CONCATENATE xsml lv_xml2 INTO  xsml .

   CLEAR : PA_AMT,settelbal.
   CLEAR : wa_tab2,tab,journalentry,AMT_WITH_TDS,AMT_WITH_TDS1.
   FREE : wa_tab2.
   FREE : tab.
   FREE : journalentry.
  ENDLOOP.



  SELECT SINGLE B~UserDescription FROM I_JournalEntry AS A
  LEFT OUTER JOIN I_User WITH PRIVILEGED ACCESS AS B  ON ( B~UserID = A~AccountingDocCreatedByUser )
     WHERE A~AccountingDocument = @document AND A~FiscalYear = @fromdate  AND A~CompanyCode = @comcode INTO @DATA(UserDescription).

   DATA ADUSTAMT  TYPE P DECIMALS 2.
   DATA NETAMT  TYPE P DECIMALS 2.

     ADUSTAMT   =  TOTAL1 - amount1 .

     if ADUSTAMT < 0 .
     ADUSTAMT = ADUSTAMT * -1.
     ELSE.
     ADUSTAMT = ADUSTAMT.
     endif.
     NETAMT = amount1 + ADUSTAMT .

    DATA(lv_xml3) =

       |<rowLineItemNode1>| &&
       |<ADJUST_AMT>{ ADUSTAMT }</ADJUST_AMT>| &&
       |</rowLineItemNode1>| &&
       |<TOT>{ TOTAL1 * p  }</TOT>| &&
       |<Totam></Totam>| &&
       |<Net_Amt>{ NETAMT }</Net_Amt>| &&
       |<txtCustomMessage>{ remark }</txtCustomMessage>| &&
       |<prepareby1>{ UserDescription }</prepareby1>| &&
       |<pannno>{ pan1 }</pannno>| &&
       |<ciinno>{ cin1 }</ciinno>| &&
       |<gsstin>{ gst1 }</gsstin>| &&
       |<ad4></ad4>| &&
       |<ad3>{ Register3 }</ad3>| &&
       |<ad2>{ Register2 }</ad2>| &&
       |<ad1>{ Register1 }</ad1>| &&
      |</Form>| .


    CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .

    REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.
    CALL METHOD ycl_test_adobe=>getpdf(
      EXPORTING
        xmldata  = lv_xml
        template = template
      RECEIVING
        result   = result12 ).


  ENDMETHOD.
ENDCLASS.
