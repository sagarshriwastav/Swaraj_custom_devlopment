CLASS zdaily_mailclass DEFINITION
PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  CLASS-METHODS
      read_data
*        IMPORTING variable        TYPE string
        RETURNING VALUE(result12) TYPE string
        RAISING   cx_static_check .
  CLASS-DATA: lx_bcs_mail TYPE REF TO cx_bcs_mail.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS ZDAILY_MAILCLASS IMPLEMENTATION.


 METHOD if_oo_adt_classrun~main.
  TRY.
  DATA(return_data) = read_data( ) .
  ENDTRY.
  ENDMETHOD.


  METHOD read_data.

  DATA gv4 TYPE datab_kk .
    DATA gv1(2) TYPE C .
    DATA gv2(2) TYPE C .
    DATA gv3 TYPE string .

    gv3 = sy-datum+0(4)  . "YEAR
    gv2 = sy-datum+4(2)  . "MONTH
    gv1 = sy-datum+6(2)  . "DAY

*    GV1 = GV1 - 01.
    GV1 = |{ GV1 ALPHA = IN }|.
    CONCATENATE GV3 GV2 GV1 INTO GV4.


   SELECT * FROM I_MaterialDocumentItem_2 AS A
   LEFT OUTER JOIN I_Supplier AS B ON ( B~Supplier = A~Supplier )
   LEFT OUTER JOIN I_ProductDescription AS C ON ( C~Product = A~Material AND C~Language = 'E' )
   WHERE A~GoodsMovementType = '101' and A~GoodsMovementRefDocType = 'B' AND a~AccountAssignmentCategory <> 'K'
   AND A~GoodsMovementIsCancelled = ''
   and A~PostingDate = @GV4
   INTO TABLE @DATA(tab).

DATA XML TYPE string .
DATA XML1 TYPE string .

data(tab2) = tab[] .

SORT tab2 by a-plant .
DELETE ADJACENT DUPLICATES FROM  tab2 COMPARING A-Plant.


 LOOP AT tab2 INTO DATA(wa2) .

  DATA(PartyBillDate)  =  'Party Bill Date' .

 data(lv) =    "  |Dear sir,<P>Please find below Purchase of the day </P><P>| &&
    |<p style="font-family:Calibri;font-size:15;">| &&
    |Dear sir,<p>Please Find below Today &apos;s Purchase Order List,</p>| &&
    |<table style="font-family:calibri;font-size:15;MARGIN:10px;width:100%;"| &&
    |cellspacing="0" cellpadding="1" | &&
    |border="1">| &&
    |<tr align = "center" >| &&
    |<th bgcolor="#a3d4ba">&nbsp;Plant&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Gate&nbsp;In&nbsp;Date&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Supplier&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Name&nbsp;&nbsp;Supplier&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Party&nbsp;&nbsp;Bill&nbsp;&nbsp;Date&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Purchase&nbsp;Order&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Party&nbsp;Bill&nbsp;Number&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Item&nbsp;Text&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Gate&nbsp;Entry&nbsp;No.&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Material&nbsp;Document&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Miro&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Invoice&nbsp;doc.&nbsp;status&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Material&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Material&nbsp;Description&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Storage&nbsp;Location&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;QuantityInBaseUnit&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Net&nbsp;Order Price&nbsp;</th>| &&
    |<th bgcolor="#a3d4ba">&nbsp;Invoice&nbsp;Value&nbsp;</th>| &&
    |</tr>| .

   LOOP AT tab INTO DATA(wa) WHERE a-Plant = wa2-a-Plant . .

   SELECT SINGLE NetPriceAmount, PURCHASEORDERITEMTEXT , netamount FROM I_PurchaseOrderItemAPI01
   WHERE PurchaseOrder = @WA-a-PurchaseOrder AND PurchaseOrderITEM = @WA-a-PurchaseOrderITEM  AND Plant = @WA-A-Plant INTO @DATA(PO) .

   SELECT SINGLE MaterialDocumentHeaderText , DocumentDate, PLANT  FROM I_MaterialDocumentHeader_2  WHERE MaterialDocument = @WA-a-MaterialDocument
   AND MaterialDocumentYear = @WA-a-MaterialDocumentYear AND Plant = @WA-A-Plant INTO @DATA(PODATE) .

   DATA(SUPP) = |{ wa-A-Supplier ALPHA = OUT }| .
   SELECT SINGLE a~GateInDate, a~Gateno  FROM YGATE_HEADER WITH PRIVILEGED ACCESS as a
   INNER JOIN YGATE_ITEMCDS WITH PRIVILEGED ACCESS as b ON ( b~Gateno = a~Gateno )
   WHERE Invoice = @PODATE-MaterialDocumentHeaderText and Invoice <> '' AND Plant = @PODATE-Plant AND b~Lifnr = @SUPP  INTO @DATA(GATE) .


   SELECT SINGLE SupplierPostingLineItemText,SupplierInvoice,ReferenceDocument,SupplierInvoiceStatus,InvoiceAmtInCoCodeCrcy
   FROM ZI_SupplierInvoiceAPI01 WHERE ReferenceDocument = @wa-A-MaterialDocument
   AND ReferenceDocumentItem = @wa-A-MaterialDocumentItem   INTO @DATA(SUPZ) .
   IF SUPZ-ReferenceDocument = '' .

   SELECT SINGLE ReferenceDocument,ReferenceDocumentItem FROM I_PurchaseOrderHistoryAPI01 WHERE  DebitCreditCode = 'S' AND PurchasingHistoryCategory = 'O'  AND PurchaseOrder = @WA-a-PurchaseOrder
   AND PurchaseOrderItem = @WA-a-PurchaseOrderItem  AND Plant = @WA-A-Plant INTO @DATA(MAT) .

   SELECT SINGLE SupplierPostingLineItemText,SupplierInvoice,ReferenceDocument,SupplierInvoiceStatus,InvoiceAmtInCoCodeCrcy
    FROM ZI_SupplierInvoiceAPI01 WHERE ReferenceDocument = @MAT-ReferenceDocument
   AND ReferenceDocumentItem = @mat-ReferenceDocumentItem and ReferenceDocument <> '' and ReferenceDocumentItem <> ''  INTO @SUPZ .

   ENDIF.

  IF SUPZ-InvoiceAmtInCoCodeCrcy = '' .
  select SINGLE AmountInCompanyCodeCurrency from I_JournalEntryItem WITH PRIVILEGED ACCESS where
  PurchasingDocument = @WA-a-purchaseorder AND PurchasingDocumentItem = @WA-a-purchaseorderitem
  AND SUBSTRING( ReferenceDocumentItem, 3 ,4 ) = @WA-a-MaterialDocumentItem
  AND ReferenceDocument  = @WA-a-MaterialDocument
  AND TransactionTypeDetermination = 'WRX' AND Ledger = '0L'
  AND Plant = @WA-a-plant into @SUPZ-InvoiceAmtInCoCodeCrcy  .
 ENDIF.

  IF SUPZ-InvoiceAmtInCoCodeCrcy = '' AND wa-a-ConsumptionPosting = 'A'.
  SUPZ-InvoiceAmtInCoCodeCrcy = PO-netamount .
 ENDIF.

if  SUPZ-InvoiceAmtInCoCodeCrcy  < 0 .
SUPZ-InvoiceAmtInCoCodeCrcy  = SUPZ-InvoiceAmtInCoCodeCrcy * -1.
ENDIF.
  DATA(lv_xml) =

    |<tr align = "center">| &&
    |<td>{ wa-A-Plant }</td>| &&
    |<td>{ GATE-GateInDate }</td>| &&
    |<td>{ | { wa-A-Supplier ALPHA = OUT } | }</td>| &&
    |<td>{ WA-B-SupplierName }</td>| &&
    |<td>{ podate-DocumentDate+6(2) }-{ podate-DocumentDate+4(2) }-{ podate-DocumentDate+0(4) }</td>| &&
    |<td>{ wa-A-PurchaseOrder }</td>| &&
    |<td>{ podate-MaterialDocumentHeaderText }</td>| &&
    |<td>{ SUPZ-SupplierPostingLineItemText }</td>| &&
    |<td>{ GATE-Gateno }</td>| &&
    |<td>{ wa-A-MaterialDocument }</td>| &&
    |<td>{ SUPZ-SupplierInvoice }</td>| &&
    |<td>{ SUPZ-SupplierInvoiceStatus }</td>| &&
    |<td>{ wa-A-Material }</td>| &&
    |<td>{ PO-PurchaseOrderItemText }</td>| &&
    |<td>{ WA-a-StorageLocation }</td>| &&
    |<td>{ wa-A-QuantityInEntryUnit }</td>| &&
    |<td>{ PO-NetPriceAmount }</td>| &&
    |<td>{ SUPZ-InvoiceAmtInCoCodeCrcy }</td>| &&
    |</tr>| .


    CONCATENATE  lv_xml XML1 INTO XML1 .


CLEAR: wa,lv_xml,PO,podate,GATE,SUPZ ,SUPP.
    ENDLOOP .

    DATA(lv_FOT) =

|</table>|
 .

CONCATENATE LV XML1 lv_FOT INTO XML .



      TRY.
      DATA(lo_mail) = cl_bcs_mail_message=>create_instance( ).
      lo_mail->set_sender( 'noreply@swarajsuiting.com' ).
      lo_mail->set_subject( 'Purchase Order' ).

if sy-sysid = 'Z6L' .   """""""""Production ID
      lo_mail->add_recipient( 'ssl-mis@swarajsuiting.com' ).
*      lo_mail->add_recipient( 'vipin.rathore@novelveritas.com' ) .  "ssl-mis@swarajsuiting.com
ELSE.
lo_mail->add_recipient( 'gajendra.s@novelveritas.com' ).
*lo_mail->add_recipient( 'vipin.rathore@novelveritas.com' ).
ENDIF.

      lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
      iv_content      = XML
      iv_content_type = 'text/html'
      ) ).

        lo_mail->send( IMPORTING et_status = DATA(lt_status) ).
        CATCH cx_bcs_mail INTO lx_bcs_mail.
      ENDTRY.

CLEAR: wa,wa2,lv_xml, xml1 , xml ,PO,podate,GATE,SUPZ .
ENDLOOP.


*//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DATA XML1_SD TYPE string .
DATA XML_SD TYPE string .


SELECT  * from I_BillingDocument AS A
LEFT OUTER JOIN I_Customer AS B ON  ( B~Customer = A~SoldToParty )
left OUTER JOIN  I_BillingDocumentItem as c on ( c~BillingDocument = a~BillingDocument )
left OUTER JOIN  I_CustomerPaymentTermsText  as d on ( d~CustomerPaymentTerms = a~CustomerPaymentTerms AND d~Language = 'E' )
WHERE A~BillingDocumentType = 'F2' AND A~BillingDocumentIsCancelled =  '' AND a~BillingDocumentDate = @GV4 INTO table @DATA(BILL) .

data(tab3) = BILL[] .

sort tab3 by c-plant.
DELETE ADJACENT DUPLICATES FROM  tab3 COMPARING C-Plant.

LOOP at tab3 into data(wa3).


data(lv_SD) =

    |<p style="font-family:Calibri;font-size:15;">| &&
    |Dear sir,<p>Please Find below Today &apos;s Invoice List,</p>| &&
    |<table style="width:100%" style="font-family:calibri;font-size:15;MARGIN:10px;"| &&
    |cellspacing="0" cellpadding="1"  | && "width="100%"
    |border="1"><tbody>| && " <tr>| &&

*
*|<h1>Sales of the day .</h1>| &&
*|<table BORDER = “1”>| &&
|<tr align = "center" >| &&
|<th bgcolor="#a3d4ba" >&nbsp;Plant&nbsp;</th>| &&
|<th bgcolor="#a3d4ba" >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Date&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th>| &&
|<th bgcolor="#a3d4ba" >&nbsp;Party&nbsp;Name&nbsp;</th>| &&
|<th bgcolor="#a3d4ba" >&nbsp;Invoice&nbsp;Number&nbsp;</th>| &&
|<th bgcolor="#a3d4ba" >&nbsp;Material&nbsp;Description&nbsp;</th>| &&
|<th bgcolor="#a3d4ba" >&nbsp;Grade&nbsp; </th>| &&
|<th bgcolor="#a3d4ba" >&nbsp;Quantity&nbsp; </th>| &&
|<th bgcolor="#a3d4ba" >&nbsp;Per&nbsp;Meter&nbsp;Rate/per&nbsp;Pick&nbsp;Rate&nbsp;</th>| &&
|<th bgcolor="#a3d4ba" >&nbsp;Mending&nbsp;and Rolling&nbsp;Charges&nbsp;</th>| &&
|<th bgcolor="#a3d4ba" >&nbsp;Invoice&nbsp;Total&nbsp;</th>| &&
|</tr>| .


LOOP AT bill INTO DATA(SD_WA) WHERE c-Plant = wa3-c-Plant .


SELECT SINGLE * from I_SalesOrderItem AS A WHERE A~SalesOrder = @SD_WA-c-SalesDocument
and A~SalesOrderItem = @SD_WA-c-SalesDocumentItem and Plant = @SD_WA-c-Plant and  Plant = @sd_wa-c-Plant  INTO @DATA(sale) .

DATA PRCGITEM TYPE P DECIMALS 2.
SELECT SINGLE ConditionRateValue from I_BillingDocumentItemPrcgElmnt  WHERE BillingDocument = @SD_WA-c-BillingDocument
AND BillingDocumentItem = @SD_WA-c-BillingDocumentItem AND ( ConditionType = 'ZPIK' OR ConditionType = 'ZR00' ) INTO @PRCGITEM .

DATA PRCGITEM2 TYPE P DECIMALS 2.
SELECT SINGLE ConditionRateValue from I_BillingDocumentItemPrcgElmnt  WHERE BillingDocument = @SD_WA-c-BillingDocument
AND BillingDocumentItem = @SD_WA-c-BillingDocumentItem AND ( ConditionType = 'ZMND' OR ConditionType = 'ZROL' )   INTO @PRCGITEM2 .

DATA(lv_xml_SD) =
|<tr align = "center">| &&
|<td>{ SD_WA-c-Plant }</td>| &&
|<td>{ sd_wa-a-BillingDocumentDate+6(2) }-{ sd_wa-a-BillingDocumentDate+4(2) }-{ sd_wa-a-BillingDocumentDate+0(4) }</td>| &&
|<td>{ sd_wa-b-OrganizationBPName1 }{ sd_wa-b-OrganizationBPName2 }</td>| &&
|<td>{ | { sd_wa-A-BillingDocument ALPHA = OUT } | }</td>| &&
|<td>{ SD_WA-c-BillingDocumentItemText }</td>| &&
|<td>{ sale-yy1_grade1_sdi }</td>| &&
|<td>{ SD_WA-c-billingquantity }</td>| &&
|<td>{ prcgitem }</td>| &&
|<td>{ prcgitem2 }</td>| &&
|<td>{ SD_WA-c-NetAmount }</td>| &&
|</tr>| .


CONCATENATE  lv_xml_SD XML1_SD INTO XML1_SD .
CLEAR: SD_wa,lv_xml_SD,sale,prcgitem,prcgitem2.
*ENDLOOP.
ENDLOOP.


DATA(lv_FOT_SD) =


|</table>| .


CONCATENATE LV_SD XML1_SD lv_FOT_SD INTO XML_SD .

    TRY.
      lo_mail = cl_bcs_mail_message=>create_instance( ).
      lo_mail->set_sender( 'noreply@swarajsuiting.com' ).
      lo_mail->set_subject( 'SALES ORDER' ).

if sy-sysid = 'Z6L' .   """""""""Production ID
      lo_mail->add_recipient( 'ssl-mis@swarajsuiting.com' ).
*      lo_mail->add_recipient( 'dashrath.rathore@novelveritas.com' ).  " ssl-mis@swarajsuiting.com
*      lo_mail->add_recipient( 'kuldeep.s@novelveritas.com' ).
ELSE.
lo_mail->add_recipient( 'gajendra.s@novelveritas.com' ).
ENDIF.

      lo_mail->set_main( cl_bcs_mail_textpart=>create_instance(
      iv_content      = XML_SD
      iv_content_type = 'text/html'
      ) ).


*lo_mail->add_attachment( cl_bcs_mail_textpart=>create_instance(
*iv_content      = XML_SD  " 'This is a text attachment'
*iv_content_type = 'text/plain'
*iv_filename     = 'Text_Attachment.txt'
*) ).

lo_mail->send( IMPORTING et_status = lt_status ).
CATCH cx_bcs_mail INTO lx_bcs_mail.
ENDTRY.

clear : sd_wa,wa3,XML1_SD, XML_SD,LV_SD,sale .
ENDLOOP.


ENDMETHOD.
ENDCLASS.
