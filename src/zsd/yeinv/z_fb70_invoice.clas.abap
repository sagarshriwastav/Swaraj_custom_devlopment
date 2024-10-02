CLASS z_fb70_invoice DEFINITION
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
        IMPORTING VALUE(variable) TYPE string
                  VALUE(year) TYPE string

        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .

  PROTECTED SECTION.
  PRIVATE SECTION.

    CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
    CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
    CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
    CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
    CONSTANTS lc_template_name TYPE string VALUE 'FB70_INVOICE/FB70_INVOICE'.
ENDCLASS.



CLASS Z_FB70_INVOICE IMPLEMENTATION.


  METHOD create_client .
    DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
    result = cl_web_http_client_manager=>create_by_http_destination( dest ).
  ENDMETHOD .


  METHOD if_oo_adt_classrun~main.
    DATA(xml)  = read_posts( variable = '1800000052' year = '2023' )   .
  ENDMETHOD.


   METHOD read_posts .

        SELECT * FROM i_OPERATIONALACCTGDOCITEM  AS a
        LEFT JOIN I_CUSTOMER  AS b ON ( a~customer = b~Customer )
        LEFT JOIN i_JOURNALENTRY AS c ON  ( a~AccountingDocument = c~AccountingDocument AND a~FiscalYear = c~FiscalYear )
        WHERE  a~AccountingDocument  =  @variable and a~FiscalYear = @year and a~TransactionTypeDetermination IS INITIAL  INTO TABLE @DATA(item)  .
        READ TABLE item INTO DATA(witem)  INDEX 1 .
         SELECT SINGLE * FROM i_OPERATIONALACCTGDOCITEM   WITH PRIVILEGED ACCESS WHERE AccountingDocument  =  @variable and FiscalYear = @year and customer IS NOT INITIAL INTO @DATA(billtoadd4)   .
         SELECT SINGLE * FROM i_OPERATIONALACCTGDOCITEM   WITH PRIVILEGED ACCESS WHERE AccountingDocument  =  @variable and FiscalYear = @year INTO @DATA(billtoadd)   .
         SELECT SINGLE * FROM I_CUSTOMER  WITH PRIVILEGED ACCESS WHERE customer = @billtoadd4-Customer INTO @DATA(billtoadd2)   .
         SELECT SINGLE * FROM i_JOURNALENTRY WITH PRIVILEGED ACCESS WHERE AccountingDocument = @billtoadd-AccountingDocument and FiscalYear = @billtoadd-FiscalYear INTO @DATA(billtoadd3)   .
         SELECT SINGLE * FROM zsd_dom_address WITH PRIVILEGED ACCESS WHERE customer = @billtoadd2-Customer INTO @DATA(billtoadd1)   .
         SELECT SINGLE * FROM i_regiontext   WHERE  region = @billtoadd2-region AND language = 'E' AND country = @billtoadd2-country  INTO  @DATA(regiontext1) .
         SELECT SINGLE * FROM yirn_det WHERE Docno = @variable  INTO @DATA(gathd).
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
   select * from i_operationalacctgdocitem
   where accountingdocument = @variable AND TaxItemAcctgDocItemRef is not INITIAL
    and AccountingDocumentItemType <> 'T' into table @data(i_billingpart2).

  loop at i_billingpart2 into data(wa_bill).
   data(wabill1) = wa_bill.
  endloop.

    data(fisc) = wa_bill-FiscalYear.
    data(comp) = wa_bill-CompanyCode.
    data(hsn_sac) = wa_bill-IN_HSNOrSACCode.
"""""""""""""""""""""""""""""""""""""""""""FETCHING PLANT FROM PROFIT CENTER"""""""
    data plant type c LENGTH 4.
    data var2   type c LENGTH 6.
     data(g_l2) = strlen( WABILL1-ProfitCenter ).
     var2       = WABILL1-ProfitCenter+4(6).
     plant     = var2+0(4).

"""""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
    if Plant = '1100'.
    DATA(gst1)  = '23AAHCS2781A1ZP'.
    Data(pan1)  = 'AAHCS2781A'.
    DATA(Register1) = 'SWARAJ SUITING LIMITED                 '.
    Data(Register2) = 'Spinning Division-I' .
    DATA(Register3) = 'B-24 To B-41 Jhanjharwada Industrial Area'.
    DATA(Register4) = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
    DATA(cin1) = 'L18101RJ2003PLC018359'.
    elseif Plant = '1200'.
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Denim Division-I' .
     Register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
     Register4 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Plant = '1300'.
     gst1  = '08AAHCS2781A1ZH'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Weaving Division-I' .
     Register3 = 'F-483 To F-487 RIICO Growth Centre'.
     Register4 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
     cin1 = 'L18101RJ2003PLC018359'.

    elseif Plant  = '1310'.
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Weaving Division-II' .
     Register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
     Register4 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Plant  = '1400'.
     gst1  = '23AAHCS2781A1ZP'.
     pan1  = 'AAHCS2781A'.
     Register1 = 'SWARAJ SUITING LIMITED'.
     Register2 = 'Process House-I' .
     Register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
     Register4 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'L18101RJ2003PLC018359'.
    elseif Plant  = '2100'.
     gst1  = '08AABCM5293P1ZT'.
     pan1  = 'AABCM5293P'.
     Register1 = 'MODWAY SUITING PVT. LIMITED'.
     Register2 = 'Weaving Division-I' .
     Register3 = '20th Km Stone, Chittorgarh Road'.
     Register4 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
     cin1 = 'U18108RJ1986PTC003788'.
    elseif Plant = '2200'.
     gst1  = '23AABCM5293P1Z1'.
     pan1  = 'AABCM5293P'.
     Register1 = 'MODWAY SUITING PVT. LIMITED'.
     Register2 = 'Weaving Division-II' .
     Register3 = 'B-24 To B-41 Jhanjharwada Industrial Area'.
     Register4 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
     cin1 = 'U18108RJ1986PTC003788'.
    ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



  DATA(lv_xml) =
               |<form1>| &&
               |<Page>| &&
               |<AddressNode>| &&
               |<subform>| &&
               |<frmBillToAddress>| &&
               |<txtLine1></txtLine1>| &&
               |<txtLine2>{ billtoadd2-CustomerName }</txtLine2>| &&
               |<txtLine3></txtLine3>| &&
               |<txtLine4>{ billtoadd2-StreetName }</txtLine4>| &&
               |<txtLine5>{ billtoadd2-cityname }({ billtoadd2-postalcode  })</txtLine5>| &&
               |<txtLine6>{ billtoadd2-Country }</txtLine6>| &&
               |<txtLine7>{ billtoadd2-Region  }({ regiontext1-RegionName })</txtLine7>| &&
               |<txtLine8></txtLine8>| &&
               |<txtRegion></txtRegion>| &&
               |<BillToPartyGSTIN>{ billtoadd2-TaxNumber3 }</BillToPartyGSTIN>| &&
               |<AckNo>{ gathd-AckNo }</AckNo>| &&
               |<AckDate>{ gathd-AckDate }</AckDate>| &&
               |<BillingDocumentdate>{ billtoadd-PostingDate }</BillingDocumentdate>| &&
               |<BillingDocument>{ billtoadd-AccountingDocument }</BillingDocument>| &&
               |</frmBillToAddress>| &&
               |<QrCode>| &&
               |<QRCodeBarcode1>{ gathd-SignedQrcode }</QRCodeBarcode1>| &&
               |</QrCode>| &&
               |<IRN>| &&
               |<IRN>{ gathd-Irn }</IRN>| &&
               |</IRN>| &&
               |</subform>| &&
               |</AddressNode>| &&
               |<Subform2>| &&
               |<DocNo>| &&
               |<sub>| &&
               |<txtReferenceNumber>{ billtoadd3-DocumentReferenceID }</txtReferenceNumber>| &&
               |<txtSalesDocument></txtSalesDocument>| &&
               |</sub>| &&
               |</DocNo>| &&
               |</Subform2>| &&
               |<Subform3>| &&
               |<frmTableBlock>| &&
               |<Table1>| &&
               |<HeaderRow/>| .

      DATA xsml TYPE string .
      DATA N TYPE STRING.

     LOOP AT item INTO witem .
             N = N + 1.
             DATA TOTAL1 TYPE P DECIMALS  2.
             TOTAL1 = TOTAL1 + witem-a-AmountInTransactionCurrency  .
             IF  witem-a-AmountInTransactionCurrency < 0.
     witem-a-AmountInTransactionCurrency =  witem-a-AmountInTransactionCurrency * -1 .
     ENDIF.

     DATA(lv_xml2) =
                    |<Row1>| &&
                    |<sno>{ N }</sno>| &&
                    |<MaterialDis.>{ witem-a-DocumentItemText }</MaterialDis.>| &&
                    |<HSN>{ witem-a-IN_HSNOrSACCode }</HSN>| &&
                    |<TotalAmount>{ witem-a-AmountInTransactionCurrency * -1 }</TotalAmount>| &&
                    |</Row1>| .

      CONCATENATE xsml lv_xml2 INTO  xsml .
      CLEAR  : witem.
      ENDLOOP .

          SELECT SUM( AmountInTransactionCurrency ) FROM  i_OPERATIONALACCTGDOCITEM WHERE
      ( TransactionTypeDetermination IN ( 'JOI' ) OR  TransactionTypeDetermination IN ( 'JII' ) ) AND  AccountingDocument  =  @variable  and FiscalYear = @year INTO @DATA(igst1)  .

            SELECT SUM( AmountInTransactionCurrency ) FROM  i_OPERATIONALACCTGDOCITEM WHERE
     ( TransactionTypeDetermination IN ( 'JOC' ) OR  TransactionTypeDetermination IN ( 'JIC' ) ) AND  AccountingDocument  =  @variable and FiscalYear = @year INTO @DATA(cgst)  .

       SELECT SUM( AmountInTransactionCurrency ) FROM  i_OPERATIONALACCTGDOCITEM WHERE
     (  TransactionTypeDetermination IN ( 'JOS' ) OR TransactionTypeDetermination IN ( 'JIS' ) )  AND  AccountingDocument  =  @variable and FiscalYear = @year INTO @DATA(sgst)  .

       SELECT SUM( AmountInTransactionCurrency ) FROM  i_OPERATIONALACCTGDOCITEM WHERE
      GLAccount EQ '4500009000' AND  AccountingDocument  =  @variable and FiscalYear = @year  INTO @DATA(roundoff)  .

       SELECT SUM( AmountInTransactionCurrency ) FROM  i_OPERATIONALACCTGDOCITEM WHERE
      GLAccount  EQ '1620000270'  AND  AccountingDocument  =  @variable and FiscalYear = @year INTO @DATA(tcs_rate)  .

        SELECT SUM( AmountInTransactionCurrency ) FROM  i_OPERATIONALACCTGDOCITEM WHERE
      AccountingDocumentType EQ 'D' AND  AccountingDocument  =  @variable and FiscalYear = @year INTO @DATA(invoicevalue)  .

   DATA TOTAL TYPE P DECIMALS  2.

          IF roundoff > '0.50'.
            TOTAL = igst1 + cgst + sgst +  TOTAL1 + 1.
            ELSEIF roundoff < '0.50'.
            TOTAL = igst1 + cgst + sgst +  TOTAL1 .
         ENDIF.

    IF TOTAL1 < 0.
    TOTAL1 = TOTAL1 * -1.
      ENDIF.

   IF igst1 < 0 .
    igst1 = igst1 * -1 .
    ENDIF.

    IF cgst < 0 .
    cgst = cgst * -1.
    ENDIF.

    IF sgst < 0.
     sgst = sgst * -1.
     ENDIF.

     IF  tcs_rate < 0.
     tcs_rate =  tcs_rate * -1 .
     ENDIF.

   IF  invoicevalue < 0 .
   invoicevalue = invoicevalue * -1.
   ENDIF.

   IF total < 0.
   total = total * -1.
   ENDIF.

     SELECT SINGLE B~UserDescription FROM I_JournalEntry AS A
  LEFT OUTER JOIN I_User WITH PRIVILEGED ACCESS AS B  ON ( B~UserID = A~AccountingDocCreatedByUser )
     WHERE A~AccountingDocument = @variable AND A~FiscalYear = @year   INTO @DATA(UserDescription).

 DATA(lv_xml3) =
               |</Table1>| &&
               |</frmTableBlock>| &&
               |</Subform3>| &&
               |<Subform5>| &&
               |<TOTAL>{ TOTAL1 }</TOTAL>| &&
               |</Subform5>| &&
               |<Terms>| &&
               |<Terms>| &&
               |<AmountInWords></AmountInWords>| &&
               |<BasicValue></BasicValue>| &&
               |<DeliveryTerms>{ witem-a-PaymentTerms }</DeliveryTerms>| &&
               |<HidePlant>{ Plant }</HidePlant>| &&
               |</Terms>| &&
               |<PricingConditions>| &&
               |<Amount>| &&
               |<FrieightChargeNew></FrieightChargeNew>| &&
               |<igst>| &&
               |<GstP></GstP>| &&
               |<GstAmount>{ igst1 }</GstAmount>| &&
               |</igst>| &&
               |<CGST>| &&
               |<CGSTP></CGSTP>| &&
               |<CgstAmount>{ cgst }</CgstAmount>| &&
               |</CGST>| &&
               |<SGST>| &&
               |<SGSTP></SGSTP>| &&
               |<SgstAmount>{ sgst }</SgstAmount>| &&
               |</SGST>| &&
               |<TCS>| &&
               |<TCSP></TCSP>| &&
               |<TCSAmount>{ tcs_rate }</TCSAmount>| &&
               |</TCS>| &&
               |<InvoiceValue>{ invoicevalue }</InvoiceValue>| &&
               |<Roundedoff>{ roundoff }</Roundedoff>| &&
               |<TotalInvoiceAmount>{ total }</TotalInvoiceAmount>| &&
               |</Amount>| &&
               |</PricingConditions>| &&
               |</Terms>| &&
               |<Remarks>| &&
               |<sub>| &&
               |<subform2>| &&
               |<CustomerContantName></CustomerContantName>| &&
               |<CustomerContantNo></CustomerContantNo>| &&
               |<Remark>{ billtoadd4-DocumentItemText }</Remark>| &&
               |<Remark2></Remark2>| &&
               |<PREPAREBYY>{ UserDescription }</PREPAREBYY>| &&
               |</subform2>| &&
               |<Subform4>| &&
               |<SMPLBCI></SMPLBCI>| &&
               |<SMPLGOTS></SMPLGOTS>| &&
               |</Subform4>| &&
               |</sub>| &&
               |</Remarks>| &&
               |</Page>| &&
           |<GSTINNO1>{ gst1 }</GSTINNO1>| &&
           |<CINNO1>{ cin1 }</CINNO1>| &&
           |<PANNO1>{ pan1 }</PANNO1>| &&
           |<Address1>{ Register1 }</Address1>| &&
           |<Address2>{ Register2 }</Address2>| &&
           |<Address3>{ Register3 }</Address3>| &&
           |<Address4>{ Register4 }</Address4>| &&
               |</form1>| .




        CONCATENATE lv_xml xsml lv_xml3 INTO lv_xml .
        REPLACE ALL OCCURRENCES OF '&' IN lv_xml WITH 'and'.

      CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
        xmldata  = lv_xml
         template = lc_template_name
      RECEIVING
        result   = result12 ).

  ENDMETHOD.
ENDCLASS.
