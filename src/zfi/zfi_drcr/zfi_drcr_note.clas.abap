 CLASS zfi_drcr_note DEFINITION
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
         RAISING   cx_static_check,

       read_posts
         IMPORTING comcode         TYPE string
                   plant           TYPE string
                   date            TYPE string
                   docno           TYPE string
                   year            TYPE string

         RETURNING VALUE(result12) TYPE string
         RAISING   cx_static_check ..

   PROTECTED SECTION.
   PRIVATE SECTION.
     CONSTANTS lc_ads_render TYPE string VALUE '/ads.restapi/v1/adsRender/pdf'.
     CONSTANTS  lv1_url    TYPE string VALUE 'https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/v1/adsRender/pdf?templateSource=storageName&TraceLevel=2'  .
     CONSTANTS  lv2_url    TYPE string VALUE 'https://btp-yvzjjpaz.authentication.eu10.hana.ondemand.com/oauth/token'  .
     CONSTANTS lc_storage_name TYPE string VALUE 'templateSource=storageName'.
     CONSTANTS  lc_template_name TYPE string VALUE ''.

ENDCLASS.



CLASS ZFI_DRCR_NOTE IMPLEMENTATION.


   METHOD create_client .
     DATA(dest) = cl_http_destination_provider=>create_by_url( url ).
     result = cl_web_http_client_manager=>create_by_http_destination( dest ).

   ENDMETHOD .


   METHOD if_oo_adt_classrun~main.

     TRY.
         DATA(return_data) = read_posts( comcode  = '1000'  plant = '1100'  date  = '' docno = '1900000002' year = ''  ) .
     ENDTRY.
   ENDMETHOD.


   METHOD read_posts.
     DATA lc_template_name1 TYPE string .

     SELECT SINGLE * FROM i_operationalacctgdocitem WHERE accountingdocument = @docno and FiscalYear = @year
     AND CompanyCode = @comcode
       AND  ( transactiontypedetermination = 'BSX' OR transactiontypedetermination = 'AGD'  )  INTO @DATA(kgdocbymiro)  .

     SELECT  * FROM yfi_crdr AS a
     LEFT JOIN i_productdescription AS b ON ( a~product = b~product AND b~language = 'E' )
      WHERE accountingdocument = @docno
        and a~FiscalYear = @year AND CompanyCode = @comcode INTO TABLE @DATA(it).

     DATA details TYPE string .
     details =  'Supplier Details' .

      IF it IS NOT INITIAL .
       READ TABLE it INTO DATA(po) INDEX 1 .
       SELECT SINGLE * FROM i_operationalacctgdocitem
       WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND supplier IS NOT INITIAL INTO @DATA(gathd).

        SELECT SINGLE * FROM ZSUPPLIER_DETAILS where Supplier = @gathd-supplier into @DATA(email).

      SELECT SINGLE * FROM i_operationalacctgdocitem
      WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode INTO @DATA(gathd1).


       SELECT SINGLE * FROM i_supplier WHERE supplier = @gathd-supplier INTO @DATA(tab_sup).
       DATA mobnum TYPE string .
       DATA gstnum TYPE string .
       gstnum = tab_sup-taxnumber3 .
       mobnum = tab_sup-phonenumber1 .

       SELECT SINGLE * FROM i_address_2 WITH PRIVILEGED ACCESS
         WHERE addressid = @tab_sup-addressid INTO @DATA(adds).

     ENDIF .




     SELECT SINGLE documentreferenceid  FROM i_journalentry WHERE accountingdocument = @docno and FiscalYear = @year
     AND CompanyCode = @comcode INTO @DATA(refe)  .
     DATA: documentname TYPE string.

data(p) = 1.

     IF gathd-accountingdocumenttype = 'RE'  .
        documentname = 'Purchase Invoice' .
     ELSEIF gathd-accountingdocumenttype = 'ZA'  .
        documentname = 'Debit Note' .
     ENDIF .


     IF  gathd1-postingkey = '11'.

       DATA(referencdate) =  gathd1-assignmentreference.
     ELSEIF
           gathd1-postingkey = '21'.

       referencdate =  gathd1-assignmentreference.
     ENDIF.



     DATA(debitnote) = gathd-accountingdocument .
     SELECT SINGLE supplierinvoiceidbyinvcgparty FROM i_supplierinvoiceapi01 WHERE supplierinvoice = @gathd-originalreferencedocument+0(10)
     AND FiscalYear = @gathd-FiscalYear AND CompanyCode = @gathd-CompanyCode INTO @DATA(ref) .





     SELECT SINGLE creationdate FROM i_purchaseorderapi01 WHERE purchaseorder = @po-A-purchasingdocument
          INTO @DATA(po_date)  .

     IF  debitnote IS INITIAL .

       debitnote = docno  .
       gathd-documentdate = |{ kgdocbymiro-postingdate }    | .

     ENDIF .

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
  elseif Plant = '1210'.
 gst1  = '08AAHCS2781A1ZH'.
 pan1  = 'AAHCS2781A'.
 register1 = 'SWARAJ SUITING LIMITED'.
 register2 = 'Storage Godown' .
 register3 = 'E-288/A, RIICO Growth Center Hamirgarh, Bhilwara-311025, Rajasthan, India'.
 cin1 = 'L18101RJ2003PLC018359'.
ENDIF.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  SELECT SINGLE B~UserDescription FROM I_JournalEntry AS A
  LEFT OUTER JOIN I_User WITH PRIVILEGED ACCESS AS B ON ( B~UserID = A~AccountingDocCreatedByUser )
     WHERE A~AccountingDocument = @docno AND A~FiscalYear = @year  AND A~CompanyCode = @comcode INTO @DATA(UserDescription).

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
  |<DebitNoteDateHIDDEN>{ gathd-postingdate }</DebitNoteDateHIDDEN>| &&
  |<DocumentNo>  { gathd-accountingdocument }</DocumentNo>| &&
  |<ReferenceNo.>  { refe }</ReferenceNo.>| &&
  |<Referencedate>{ referencdate }</Referencedate>| &&
  |<Referencedate>{  gathd-DocumentDate+6(2) }/{ gathd-DocumentDate+4(2) }/{ gathd-DocumentDate+0(4) }</Referencedate>| &&
  |<PurchaseNo>{ po-A-purchasingdocument }</PurchaseNo>| &&
  |<PurchaseDate>{ po_date+6(2) }/{ po_date+4(2) }/{ po_date+0(4) }</PurchaseDate>| &&
  |<plant_no>{ PLANTADD-Plant }</plant_no>| &&
  |<PREPAREBYY>{ UserDescription }</PREPAREBYY>| &&
  |<DOCUMENT>{ documentname }</DOCUMENT>| &&
  |<DebitNoteDate>{ po-A-postingdate+6(2) }/{ po-A-postingdate+4(2) }/{ po-A-postingdate+0(4) }</DebitNoteDate>| &&
  |</CreditDetails>| &&
  |<SupplierDetails>| &&
  |<DetailsofSupplier>{ details } </DetailsofSupplier>| &&
  |<Name>  { adds-addresseefullname }</Name>| &&
  |<Address>{ adds-street } { adds-streetname } { adds-streetprefixname1 }</Address>| &&
  |<City>  { adds-cityname }</City>| &&
  |<PinCode>  { adds-postalcode }</PinCode>| &&
  |<State>  { adds-region }</State>| &&
  |<Phone>{ mobnum } </Phone>| &&
  |<GSTIN>{ gstnum }</GSTIN>| &&
  |<Email_id>{ email-EmailAddress } </Email_id>| &&
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

    IF kgdocbymiro  IS NOT INITIAL .

       SORT it BY A-purchasingdocumentitem .
     ENDIF .
*+++++++++++++++++++++++++++++++++++++++++


     LOOP AT it INTO DATA(iv). " WHERE A-GLAccount <> '3500001050'  AND A-GLAccount <> '4500009010'.
       IF iv-a-purchaseorderqty IS NOT INITIAL .
           DATA(ln) = iv-A-purchasingdocumentitem .


          SHIFT ln RIGHT  DELETING TRAILING '0' .
           DATA linitem TYPE znum6 .

     SELECT SINGLE  amountincompanycodecurrency ,  gstrate FROM i_operationalacctgdocitem LEFT OUTER JOIN ytax_code2  ON ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                             WHERE  accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND taxitemacctgdocitemref = @IV-A-txgrp
                                          AND   ( transactiontypedetermination = 'JIC' OR transactiontypedetermination = 'JOC' ) AND ytax_code2~taxcode  NOT LIKE 'R%'  INTO    @DATA(cgst) .
           SELECT SINGLE   amountincompanycodecurrency , gstrate FROM i_operationalacctgdocitem LEFT OUTER JOIN ytax_code2  ON ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                    WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND  taxitemacctgdocitemref =  @IV-A-txgrp AND
                                   ( transactiontypedetermination = 'JIS' OR transactiontypedetermination = 'JOS' ) AND ytax_code2~taxcode  NOT LIKE 'R%'  INTO  @DATA(sgst) .
           SELECT SINGLE  amountincompanycodecurrency , gstrate FROM i_operationalacctgdocitem LEFT OUTER JOIN ytax_code2  ON ( i_operationalacctgdocitem~taxcode = ytax_code2~taxcode )
                                   WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND  taxitemacctgdocitemref = @IV-A-txgrp AND
                                  ( transactiontypedetermination = 'JII' OR transactiontypedetermination = 'JOI' )  AND ytax_code2~taxcode  NOT LIKE 'R%'  INTO @DATA(igst) .

           SELECT SINGLE  amountincompanycodecurrency FROM i_operationalacctgdocitem
                                  WHERE accountingdocument = @docno and FiscalYear = @year AND CompanyCode = @comcode AND taxitemacctgdocitemref =  @linitem AND
                                  transactiontypedetermination = 'DIF'  INTO @DATA(roundof) .



           SELECT SINGLE productdescription FROM i_productdescription WHERE  product = @iv-A-product AND language = 'E'  INTO @DATA(text1) .


*    ENDIF.





         totamt  =  iv-a-amt + ( cgst-AmountInCompanyCodeCurrency   ) + ( sgst-AmountInCompanyCodeCurrency   ) + ( igst-AmountInCompanyCodeCurrency   ) .

   DATA taxable TYPE string.
         DATA gsthp TYPE string.
         DATA gsthp1 TYPE string.
         DATA cgstamount TYPE string.
         DATA sgstrate TYPE string.
         DATA sgstrate1 TYPE string.
         DATA sgstamount TYPE string.
         DATA igstrate TYPE string.
         DATA igstamount TYPE string.
         DATA tot TYPE string.
         DATA Rate TYPE string.

         IF iv-a-amt LT 0.
           taxable = -1 * iv-a-amt.
         ELSE.
           taxable =   iv-a-amt.
         ENDIF.

         IF cgst-gstrate LT 0.
           gsthp = -1 * cgst-gstrate.
         ELSE.
           gsthp = cgst-gstrate.
         ENDIF.

         IF cgst-amountincompanycodecurrency LT 0.
           cgstamount = -1 * cgst-amountincompanycodecurrency.
         ELSE.
           cgstamount = cgst-amountincompanycodecurrency.
         ENDIF.

         IF sgst-gstrate LT 0.
           sgstrate = -1 * sgst-gstrate.
         ELSE.
           sgstrate = sgst-gstrate.
         ENDIF.

         IF sgst-amountincompanycodecurrency LT 0.
           sgstamount = -1 * sgst-amountincompanycodecurrency.
         ELSE.
           sgstamount = sgst-amountincompanycodecurrency.
         ENDIF.

         IF igst-gstrate LT 0.
           igstrate = -1 * igst-gstrate.
         ELSE.
           igstrate = igst-gstrate.
         ENDIF.

         IF igst-amountincompanycodecurrency LT 0.
           igstamount = -1 * igst-amountincompanycodecurrency.
         ELSE.
           igstamount = igst-amountincompanycodecurrency.
         ENDIF.

         IF totamt LT 0.
           tot = -1 * totamt.
         ELSE.
           tot = totamt.
         ENDIF.

  if  gsthp <> '0.00' .
   gsthp1 =  gsthp / 2 .

  else .

      gsthp1 = gsthp1.

  ENDIF.

 if sgstrate <> '0.00' .
  sgstrate1 =  sgstrate / 2 .

 else .
  sgstrate1 =  sgstrate .
 ENDIF.



         DATA(lv_xml2) =
       |<Table8>| &&
       |<Row1>| &&
       |<Sno>{ n }</Sno>| &&
       |<Description>{ text1 } / { iv-A-in_hsnorsaccode }</Description>| &&
       |<Qty>{ iv-A-purchaseorderqty }</Qty>| &&
       |<UOM>{ iv-A-BaseUnit }</UOM>| &&
       |<Rate></Rate>| &&
       |<Taxable>{ taxable }</Taxable>| &&
       |<CGSTRAte>{ gsthp1 }%</CGSTRAte>| &&
       |<CGSTamount>{ cgstamount }</CGSTamount>| &&
       |<SGSTRATE>{ sgstrate1 }%</SGSTRATE>| &&
       |<SGSTamount>{ sgstamount }</SGSTamount>| &&
       |<IGSTRATE>{ igstrate }%</IGSTRATE>| &&
       |<IGSTamount>{ igstamount }</IGSTamount>| &&
       |<TOT>{ tot }</TOT>| &&
       |</Row1>| &&
       |</Table8>| .

         subamt = subamt + tot .

       CONCATENATE xsml lv_xml2 INTO  xsml .
       ENDIF .
       CLEAR  : lv_xml2,iv,cgst,sgst,igst,totamt,
           lv_xml2,iv,cgst,sgst,igst,totamt ,tot,taxable,gsthp,cgstamount,sgstrate,sgstamount,igstrate,igstamount, text1. " linitem ,
     ENDLOOP .


*##########################################VV#######V##############VV############################LOOP"
     IF kgdocbymiro IS INITIAL .

       READ TABLE it INTO DATA(dta) INDEX 1 ."WITH KEY A-glaccount = '3201000000' .

       dta-A-AMT  = -1 * dta-A-AMT  .

     ELSE .
       SELECT SINGLE * FROM i_operationalacctgdocitem WHERE accountingdocument = @docno and FiscalYear = @year
       AND CompanyCode = @comcode  AND glaccount = '4301400000' INTO @DATA(dta1)  .

       dta-A-amt  = -1 * dta1-amountintransactioncurrency  .


     ENDIF .

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



   DATA invoicetotal TYPE i_operationalacctgdocitem-amountincompanycodecurrency .
     DATA remark TYPE string  .

     SELECT SINGLE amountincompanycodecurrency, documentitemtext FROM i_operationalacctgdocitem WHERE
     ( transactiontypedetermination = 'EGK' OR transactiontypedetermination = 'KBS' OR transactiontypedetermination = 'AGD' )
      AND accountingdocument = @gathd-accountingdocument and FiscalYear = @gathd-FiscalYear AND CompanyCode = @comcode INTO ( @invoicetotal, @remark ) .

     SELECT SINGLE amountincompanycodecurrency FROM i_operationalacctgdocitem WHERE
    GLAccount = '4500009010'
     AND accountingdocument = @gathd-accountingdocument and FiscalYear = @gathd-FiscalYear AND CompanyCode = @comcode INTO @DATA(roundoff) .


     IF remark IS INITIAL .
       remark = kgdocbymiro-documentitemtext  .

     ENDIF .

     DATA TOTAMTGS TYPE P DECIMALS 2.
     DATA invoicevalue11 TYPE string .
     DATA invoicevalue2 TYPE p DECIMALS 2.
     DATA roundof1 TYPE zpdec2 .

   IF dta-A-AMT  LT 0 .
   TOTAMTGS  =  subamt +  ( dta-A-AMT * 1 ) .
   ELSE.
*   TOTAMTGS  =  subamt +  dta-A-AMT  .
    TOTAMTGS  =  subamt .
   ENDIF.


      invoicevalue11 = TOTAMTGS .

      SPLIT invoicevalue11 AT '.' INTO DATA(c) DATA(d) .

      IF d GE 50 .
        invoicevalue2 = c + 1 .
        roundof1 = invoicevalue2 - invoicevalue11 .
      ELSE .
        invoicevalue2 = c .
        roundof1 = invoicevalue2 - invoicevalue11 .

      ENDIF .


      DATA(lv_xml3) =   |</Table10>| &&
     |</Tab2>| &&
     |<Subform4>| &&
     |<Remark>{ remark }</Remark>| &&
     |<AmountInWords></AmountInWords>| &&
     |<Subform5>| &&
     |<FrightCharges></FrightCharges>| &&
     |<RoundingOff>{ roundof1 }</RoundingOff>| &&
     |<InvoiceTotal>{ invoicevalue2 }</InvoiceTotal>| &&
     |</Subform5>| &&
     |</Subform4>| &&
     |</Page1>| &&
     |</form1>| .



     CONCATENATE lv_xml xsml  lv_xml_middle   lv_xml3 INTO DATA(lv_xml1) .
     DATA template TYPE string .
*     template =  'Fi_Supplier_Deb_Cre_Note/FI_SUPPLIER_DEB_CRE_NOTE' .
*     template =  'Fi_Supplier_Deb_Cre/FI_SUPPLIER_DEB_CRE' .

     template =  'ZFI_PURCHASE_FIN/ZFI_PURCHASE_FIN'  .

     CALL METHOD ycl_test_adobe=>getpdf(
       EXPORTING
         xmldata  = lv_xml1
         template = template
       RECEIVING
         result   = result12 ).



   ENDMETHOD.
ENDCLASS.
