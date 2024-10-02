CLASS zfi_dc_debit_credit DEFINITION
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
*DATA L1 TYPE NU

     CLASS-METHODS :

       create_client
         IMPORTING url           TYPE string
         RETURNING VALUE(result) TYPE REF TO if_web_http_client
         RAISING   cx_static_check,

       read_posts
         IMPORTING comcode         TYPE string
                   plant           TYPE string
                   date            TYPE string
                   docno           TYPE string
                   year            TYPE string

         RETURNING VALUE(result12) TYPE string
         RAISING   cx_static_check .

   PROTECTED SECTION.
   PRIVATE SECTION.
     CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
     CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
     CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
     CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
     CONSTANTS  lc_template_name TYPE string VALUE ''.

ENDCLASS.



CLASS ZFI_DC_DEBIT_CREDIT IMPLEMENTATION.


   METHOD create_client .
     DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
     result = cl_web_http_client_manager=>create_by_http_destination( dest ).

   ENDMETHOD .


   METHOD if_oo_adt_classrun~main.

     TRY.
         DATA(return_data) = read_posts( comcode  = '1000'  plant = '1100'  date  = '' docno = '1600000019' year = ''  ) .
     ENDTRY.
   ENDMETHOD.


   METHOD read_posts.
     DATA lc_template_name1 TYPE string .
*     SELECT  * FROM yfi_crdr AS a
*     LEFT JOIN i_productdescription AS b ON ( a~product = b~product AND b~language = 'E' )
*      WHERE accountingdocument = @docno INTO TABLE @DATA(it).
 SELECT SINGLE * FROM I_OPERATIONALACCTGDOCITEM WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode
   AND  ( TransactionTypeDetermination = 'BSX' OR TransactionTypeDetermination = 'AGD'  )  INTO @DATA(KGDOCBYMIRO)  .


IF SY-SUBRC IS NOT INITIAL .
      select * from I_OPERATIONALACCTGDOCITEM  where accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode
      and TaxItemAcctgDocItemRef is NOT  INITIAL and AccountingDocumentItemType ne 'T'
       INTO TABLE @DATA(it).
 ELSE .
 select * from I_OPERATIONALACCTGDOCITEM  where accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode
     and AccountingDocumentItemType ne 'T' AND TransactionTypeDetermination = 'AGD'
       INTO TABLE @it .
*OR  TransactionTypeDetermination = 'AGD'
  ENDIF.

  IF KGDOCBYMIRO-AccountingDocumentType = 'DC' .
* DELETE IT .
 select * from I_OPERATIONALACCTGDOCITEM  where accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode
      and TaxItemAcctgDocItemRef is NOT  INITIAL and AccountingDocumentItemType ne 'T'
       INTO TABLE @it.
    ENDIF.
     data details type string .
  details =  'Details Of Customer' .

  if details is initial .

    details =  'Details Of Supplier' .

  endif .

     IF it IS NOT INITIAL .
     READ TABLE IT INTO DATA(PO) INDEX 1 .
       SELECT SINGLE * FROM i_operationalacctgdocitem
       WHERE accountingdocument = @docno  and FiscalYear = @year AND CompanyCode = @comcode AND supplier IS NOT INITIAL INTO @DATA(gathd).

              SELECT SINGLE * FROM i_operationalacctgdocitem
       WHERE accountingdocument = @docno and FiscalYear = @year  AND CompanyCode = @comcode INTO @DATA(gathd1).


       SELECT SINGLE * FROM i_supplier WHERE supplier = @gathd-supplier INTO @DATA(tab_sup).
     DATA MOBNUM TYPE STRING .
     DATA GSTNUM TYPE STRING .
     GSTNUM = tab_sup-TaxNumber3 .
     MOBNUM = tab_sup-PhoneNumber1 .

      IF KGDOCBYMIRO-AccountingDocumentType = 'DC' .
      SELECT SINGLE addressid FROM I_Customer WHERE Customer = @KGDOCBYMIRO-Customer INTO @tab_sup-addressid .
      SELECT SINGLE * FROM I_Customer WHERE Customer = @KGDOCBYMIRO-Customer INTO @DATA(tab_cus).
        GSTNUM = tab_CUS-TaxNumber3 .
      ENDIF .

      SELECT SINGLE * FROM I_Address_2 WITH PRIVILEGED ACCESS
        WHERE addressid = @tab_sup-addressid INTO @DATA(adds).

*    MOBNUM =  tab_CUS-P .
   ENDIF .




SELECT SINGLE DOCUMENTREFERENCEID  FROM I_JOURNALENTRY WHERE AccountingDocument = @docno and FiscalYear = @year
AND CompanyCode = @comcode INTO @DATA(REFE)  .
 DATA: documentname TYPE string.



IF
   gathd1-AccountingDocumentType = 'DC'  .

documentname = 'Debit Note' .
DATA(P) = -1 .

 ELSE.
 P = 1 .
documentname = 'Credit Note'  .

  ENDIF .

  IF  gathd1-PostingKey = '11'.

  DATA(Referencdate) =  gathd1-AssignmentReference.
  ELSEIF
        gathd1-PostingKey = '21'.

        Referencdate =  gathd1-AssignmentReference.
        ENDIF.



data(debitnote) = gathd-AccountingDocument .
  select single SupplierInvoiceIDByInvcgParty from I_SupplierInvoiceAPI01 where SupplierInvoice = @gathd-OriginalReferenceDocument+0(10)
  AND CompanyCode = @gathd-CompanyCode AND FiscalYear = @gathd-FiscalYear into @data(ref) .





 SELECT SINGLE CreationDate FROM I_PurchaseOrderAPI01 WHERE PurchaseOrder = @PO-PurchasingDocument
      INTO @DATA(PO_DATE)  .

if  debitnote is INITIAL .

debitnote = docno  .
 gathd-documentdate = |{ KGDOCBYMIRO-PostingDate }    | .

endif .

select single * from zsd_plant_address WITH PRIVILEGED ACCESS where PLANT = @plant INTO @DATA(PLANTADD).
""""""""""""""""""""""""""""""""""""""""""""""""""""Plant Wise Address, GST & PAN"""""""""""""""""""""""""""""""""""
DATA gst1 TYPE STRING.
DATA pan1 TYPE STRING.
DATA Register1 TYPE STRING.
DATA Register2 TYPE STRING.
DATA Register3 TYPE STRING.
DATA cin1 TYPE STRING.

 if PLANTADD-Plant  = '1100'.
gst1  = '23AAHCS2781A1ZP'.
pan1  = 'AAHCS2781A'.
Register1 = 'SWARAJ SUITING LIMITED'.
Register2 = 'Spinning Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
Register3 = ' Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1200'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Denim Division-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch - 458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1300'.
 gst1  = '08AAHCS2781A1ZH'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-I, F-483 To F-487 RIICO Growth Centre' .
 Register3 = 'Hamirgarh, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1310'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '1400'.
 gst1  = '23AAHCS2781A1ZP'.
 pan1  = 'AAHCS2781A'.
 Register1 = 'SWARAJ SUITING LIMITED'.
 Register2 = 'Process House-I, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'L18101RJ2003PLC018359'.
elseif PLANTADD-Plant  = '2100'.
 gst1  = '08AABCM5293P1ZT'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-I, 20th Km Stone, Chittorgarh Road' .
 Register3 = 'Takhatpura, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'U18108RJ1986PTC003788'.
elseif PLANTADD-Plant  = '2200'.
 gst1  = '23AABCM5293P1Z1'.
 pan1  = 'AABCM5293P'.
 Register1 = 'MODWAY SUITING PVT. LIMITED'.
 Register2 = 'Weaving Division-II, B-24 To B-41 Jhanjharwada Industrial Area' .
 Register3 = 'Jhanjharwada, Neemuch-458441, Madhya Pradesh, India'.
 cin1 = 'U18108RJ1986PTC003788'.
ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""






    DATA(lv_xml) =
     |<form1>| &&
 |<Page1>| &&
 |<Subform1>| &&
  |<PlantHead>{ Register1 }</PlantHead>| &&
  |<add1>{ Register2 }</add1>| &&
  |<add2>{ Register3 }</add2>| &&
  |<Subform7>| &&
  |<CINNo>{ cin1 }</CINNo>| &&
  |<GSTIN>{ gst1 }</GSTIN>| &&
  |<PAN>{ pan1 }</PAN>| &&
  |</Subform7>| &&
 |</Subform1>| &&
 |<Subform2>| &&
|<DOCUMENT>{ documentname }</DOCUMENT>| &&
|</Subform2>| &&
 |<Subform3>| &&
 |<CreditDetails>| &&
 |<DOCUMENT>{ documentname }</DOCUMENT>| &&
 |<DOCUMENT>{ documentname }</DOCUMENT>| &&
 |<DebitNoteNo>{ debitnote }</DebitNoteNo>| &&
 |<DebitNoteNoHIDE></DebitNoteNoHIDE>| &&
 |<DebitNoteDateHIDDEN>{ gathd-PostingDate }</DebitNoteDateHIDDEN>| &&
 |<DocumentNo>  { gathd-accountingdocument }</DocumentNo>| &&
 |<ReferenceNo.>  { REFE }</ReferenceNo.>| &&
* |<Referencedate>{ Referencdate }</Referencedate>| &&
 |<Referencedate>{ gathd-DocumentDate+6(2) }/{ gathd-DocumentDate+4(2) }/{ gathd-DocumentDate+0(4) }</Referencedate>| &&
 |<PurchaseNo>{ PO-PurchasingDocument }</PurchaseNo>| &&
 |<PurchaseDate>{ PO_DATE+6(2) }/{ PO_DATE+4(2) }/{ PO_DATE+0(4) }</PurchaseDate>| &&
 |<DOCUMENT>{ documentname }</DOCUMENT>| &&
 |<DebitNoteDate>{ PO-PostingDate+6(2) }/{ PO-PostingDate+4(2) }/{ PO-PostingDate+0(4) }</DebitNoteDate>| &&
 |</CreditDetails>| &&
 |<SupplierDetails>| &&
 |<DetailsofSupplier>{ details } </DetailsofSupplier>| &&
 |<Name>  { adds-AddresseeFullName }</Name>| &&
 |<Address>{ adds-street } { adds-streetname } { adds-streetprefixname1 }</Address>| &&
 |<City>  { adds-CityName }</City>| &&
 |<PinCode>  { adds-postalcode }</PinCode>| &&
 |<State>  { adds-region }</State>| &&
 |<Phone>{ MOBNUM } </Phone>| &&
 |<GSTIN>{ GSTNUM }</GSTIN>| &&
 |<PAN></PAN>| &&
 |</SupplierDetails>| &&
 |</Subform3>| &&
 |<Tab1>| &&
 |<Table1>| &&
 |<Row1>| &&
 |<Table2>| &&
 |<Row1/>| &&
 |<Row2>| &&
 |<Table5>| &&
 |<Row1/>| &&
 |</Table5>| &&
 |</Row2>| &&
 |</Table2>| &&
 |<Table3>| &&
 |<Row1/>| &&
 |<Row2>| &&
 |<Table6>| &&
 |<Row1/>| &&
 |</Table6>| &&
 |</Row2>| &&
 |</Table3>| &&
 |<Table4>| &&
 |<Row1/>| &&
 |<Row2>| &&
 |<Table7>| &&
 |<Row1/>| &&
 |</Table7>| &&
 |</Row2>| &&
 |</Table4>| &&
 |</Row1>| &&
 |</Table1>|

      .

     DATA subamt TYPE p DECIMALS 2 .
     DATA totamt TYPE p DECIMALS 2 .
     DATA xsml TYPE string .
     DATA n TYPE P VALUE 0 .
     DATA total  TYPE p DECIMALS 2 .


*+++++++++++++++++++++++++++++++++++++++++


     LOOP AT it INTO DATA(iv) WHERE  GLAccount <> '3500001050'  AND GLAccount <> '4500009010'  .
     if iv-GLAccount ne '3201000000' .

         n = n + 1.


SELECT SINGLE * FROM I_GLAccountText WHERE GLAccount = @iv-GLAccount AND
Language = 'E' INTO  @DATA(GLDES)  .

IF KGDOCBYMIRO  IS INITIAL .
         SELECT SINGLE  amountincompanycodecurrency ,  gstrate FROM i_operationalacctgdocitem left outer join ytax_code2  on ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                  WHERE  accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND taxitemacctgdocitemref = @iv-taxitemacctgdocitemref
                               AND    transactiontypedetermination = 'JIC'  INTO    @DATA(cgst)  .
         SELECT SINGLE   amountincompanycodecurrency , gstrate FROM i_operationalacctgdocitem left outer join ytax_code2  on ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                  WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND  taxitemacctgdocitemref = @iv-taxitemacctgdocitemref AND
                                  transactiontypedetermination = 'JIS'  INTO  @DATA(sgst) .
         SELECT SINGLE  amountincompanycodecurrency , gstrate FROM i_operationalacctgdocitem left outer join ytax_code2  on ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                 WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND  taxitemacctgdocitemref = @iv-taxitemacctgdocitemref AND
                                 transactiontypedetermination = 'JII'  INTO @DATA(igst) .

         SELECT SINGLE  amountincompanycodecurrency FROM i_operationalacctgdocitem
                                WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND taxitemacctgdocitemref = @iv-taxitemacctgdocitemref AND
                                transactiontypedetermination = 'DIF'  INTO @DATA(roundof) .
 DATA TEXT1 TYPE STRING .
TEXT1  = GLDES-GLAccountLongName .

ELSEIF KGDOCBYMIRO-AccountingDocumentType = 'KG' .
DATA(LN) = iv-PurchasingDocumentItem .


SHIFT LN RIGHT  DELETING TRAILING '0' .
DATA LINITEM TYPE ZNUM6 .


LINITEM  =    |{ LN ALPHA = IN }|.

*DATA(ITEM) =
*iv-PurchasingDocumentItem = '000001' .


SELECT SINGLE  amountincompanycodecurrency ,  gstrate FROM i_operationalacctgdocitem left outer join ytax_code2  on ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                  WHERE  accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND taxitemacctgdocitemref = @LINITEM
                               AND   ( transactiontypedetermination = 'JIC' OR transactiontypedetermination = 'JOC' )   INTO    @cgst  .
         SELECT SINGLE   amountincompanycodecurrency , gstrate FROM i_operationalacctgdocitem left outer join ytax_code2  on ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                  WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND  taxitemacctgdocitemref =  @LINITEM AND
                                 ( transactiontypedetermination = 'JIS' OR transactiontypedetermination = 'JOS' )   INTO  @sgst .
         SELECT SINGLE  amountincompanycodecurrency , gstrate FROM i_operationalacctgdocitem left outer join ytax_code2  on ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                 WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND  taxitemacctgdocitemref = @LINITEM AND
                                ( transactiontypedetermination = 'JII' OR transactiontypedetermination = 'JOI' )   INTO @igst .

         SELECT SINGLE  amountincompanycodecurrency FROM i_operationalacctgdocitem
                                WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND taxitemacctgdocitemref =  @LINITEM AND
                                transactiontypedetermination = 'DIF'  INTO @roundof .



SELECT SINGLE ProductDescription FROM i_productdescription WHERE  product = @IV-product AND language = 'E'  INTO @TEXT1 .


ELSEIF KGDOCBYMIRO-AccountingDocumentType = 'DC' .


 SELECT SINGLE  amountincompanycodecurrency ,  gstrate FROM i_operationalacctgdocitem left outer join ytax_code2  on ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                  WHERE  accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND taxitemacctgdocitemref = @iv-taxitemacctgdocitemref
                               AND    ( transactiontypedetermination = 'JIC' OR transactiontypedetermination = 'JOC' ) INTO    @cgst  .
         SELECT SINGLE   amountincompanycodecurrency , gstrate FROM i_operationalacctgdocitem left outer join ytax_code2  on ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                  WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND  taxitemacctgdocitemref = @iv-taxitemacctgdocitemref AND
                                  transactiontypedetermination = 'JOS'  INTO  @sgst .
         SELECT SINGLE  amountincompanycodecurrency , gstrate FROM i_operationalacctgdocitem left outer join ytax_code2  on ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                 WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND  taxitemacctgdocitemref = @iv-taxitemacctgdocitemref AND
                                 transactiontypedetermination = 'JOI'  INTO @igst .

         SELECT SINGLE  amountincompanycodecurrency FROM i_operationalacctgdocitem
                                WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND taxitemacctgdocitemref = @iv-taxitemacctgdocitemref AND
                                transactiontypedetermination = 'DIF'  INTO @roundof .

TEXT1  = GLDES-GLAccountLongName .

ENDIF.




         totamt  =  iv-AmountInCompanyCodeCurrency + ( cgst-AmountInCompanyCodeCurrency   ) + ( sgst-AmountInCompanyCodeCurrency   ) + ( igst-AmountInCompanyCodeCurrency   ) .

*      select single * from i_taxitem WITH PRIVILEGED ACCESS where AccountingDocument = @iv-a-AccountingDocument into @data(taxrate) .

    IF iv-TransactionTypeDetermination = 'WIT'.
        totamt =  -1 * totamt  .
        ENDIF.


         DATA(lv_xml2) =
       |<Table8>| &&
       |<Row1>| &&
       |<Sno>{ n }</Sno>| &&
       |<Description>{ TEXT1 } { IV-IN_HSNOrSACCode }</Description>| &&
*       |<HAN>{ iv-GLAccount }</HAN>| &&
       |<Text>{ iv-DocumentItemText } </Text>| &&
*       |<QTY{ iv-a-purchaseorderqty }</QTY>| &&
*       |<Rate>{ P * iv-a-amt / iv-a-purchaseorderqty }</Rate>| &&
       |<Taxable>{  P * iv-AmountInCompanyCodeCurrency }</Taxable>| &&
       |<CGSTRAte>{ cgst-gstrate }%</CGSTRAte>| &&
       |<CGSTamount>{  P * cgst-AmountInCompanyCodeCurrency }</CGSTamount>| &&
       |<SGSTRATE>{ sgst-gstrate }%</SGSTRATE>| &&
       |<SGSTamount>{ P * sgst-AmountInCompanyCodeCurrency }</SGSTamount>| &&
       |<IGSTRATE>{ igst-gstrate }%</IGSTRATE>| &&
       |<IGSTamount>{ P * igst-AmountInCompanyCodeCurrency }</IGSTamount>| &&
       |<TOT>{ p * totamt }</TOT>| &&
       |</Row1>| &&
       |</Table8>|
       .
         subamt = subamt + totamt .
         CONCATENATE xsml lv_xml2 INTO  xsml .
*       ENDIF .
       CLEAR  : lv_xml2,iv,cgst,sgst,igst,totamt , LINITEM ,TEXT1.
       endif .
     ENDLOOP .



IF KGDOCBYMIRO IS INITIAL .

read table it into data(dta) with key GLAccount = '3201000000' .

   dta-AmountInTransactionCurrency  = -1 * dta-AmountInTransactionCurrency  .

else .
SELECT SINGLE * FROM I_OPERATIONALACCTGDOCITEM WHERE accountingdocument = @docno and FiscalYear = @year
AND CompanyCode = @comcode  AND GLAccount = '4301400000' INTO @dta  .

   dta-AmountInTransactionCurrency  = -1 * dta-AmountInTransactionCurrency  .


endif .
*##########################################VV#######V##############VV############################LOOP"

     DATA(lv_xml_middle) =
     |</Tab1>| &&
     |<Tab2>| &&
     |<Table9>| &&
     |<Row1>| &&
     |<Table2>| &&
     |<Row1/>| &&
     |<Row2>| &&
     |<Table5>| &&
     |<Row1/>| &&
     |</Table5>| &&
     |</Row2>| &&
     |</Table2>| &&
     |<Table3>| &&
     |<Row1/>| &&
     |<Row2>| &&
     |<Table6>| &&
     |<Row1/>| &&
     |</Table6>| &&
     |</Row2>| &&
     |</Table3>| &&
     |<Table3>| &&
     |<Row1/>| &&
     |<Row2>| &&
     |<Table6>| &&
     |<Row1/>| &&
     |</Table6>| &&
     |</Row2>| &&
     |</Table3>| &&
     |<Table4>| &&
     |<Row1/>| &&
     |<Row2>| &&
     |<Table7>| &&
     |<Row1/>| &&
     |</Table7>| &&
     |</Row2>| &&
     |</Table4>| &&
     |</Row1>| &&
     |</Table9>| &&
     |<Table10>| .



 DATA InvoiceTotal TYPE i_operationalacctgdocitem-amountincompanycodecurrency .
 DATA REMARK TYPE STRING  .

SELECT SINGLE amountincompanycodecurrency, DocumentItemText FROM i_operationalacctgdocitem WHERE
( TransactionTypeDetermination = 'EGK' or TransactionTypeDetermination = 'KBS' OR TransactionTypeDetermination = 'AGD' )
 AND AccountingDocument = @gathd-AccountingDocument and FiscalYear = @gathd-FiscalYear AND CompanyCode = @comcode INTO ( @InvoiceTotal, @REMARK ) .

 SELECT SINGLE amountincompanycodecurrency FROM i_operationalacctgdocitem WHERE
TransactionTypeDetermination = 'DIF'
 AND AccountingDocument = @gathd-AccountingDocument and FiscalYear = @gathd-FiscalYear AND CompanyCode = @comcode INTO @DATA(ROUNDOFF) .


IF REMARK IS INITIAL .
REMARK = KGDOCBYMIRO-DocumentItemText  .

ENDIF .



     DATA(lv_xml3) =   |</Table10>| &&
     |</Tab2>| &&
     |<Subform4>| &&
     |<Remark>{ REMARK }</Remark>| &&
     |<AmountInWords></AmountInWords>| &&
     |<Subform5>| &&
     |<RoundingOff>{ dta-AmountInTransactionCurrency }</RoundingOff>| &&
     |<InvoiceTotal>{ p * subamt +  dta-AmountInTransactionCurrency }</InvoiceTotal>| &&
     |</Subform5>| &&
     |</Subform4>| &&
     |</Page1>| &&
     |</form1>| .



     CONCATENATE lv_xml xsml  lv_xml_middle  lv_xml3 INTO DATA(lv_xml1) .
     DATA template TYPE string .
     template =  'ZFI_DRCR_FIN/ZFI_DRCR_FIN' .


     CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = lv_xml1
         template = template
       RECEIVING
         result   = result12 ).



   ENDMETHOD.
ENDCLASS.
