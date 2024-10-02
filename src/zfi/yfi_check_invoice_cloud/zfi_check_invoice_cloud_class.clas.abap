CLASS zfi_check_invoice_cloud_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_badi_interface .
    INTERFACES if_ex_mrm_check_invoice_cloud .
    interfaces IF_HTTP_SERVICE_EXTENSION .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZFI_CHECK_INVOICE_CLOUD_CLASS IMPLEMENTATION.


  METHOD if_ex_mrm_check_invoice_cloud~check_invoice.

**********************************************************Line Item Amount Check For Migo********************************

loop at itemswithporeference ASSIGNING FIELD-SYMBOL(<fs_gs1>) .


  SELECT SINGLE b~TaxCode , a~PURCHASEORDERTYPE , a~PricingProcedure , b~AccountAssignmentCategory  FROM I_PURCHASEORDERAPI01 WITH PRIVILEGED ACCESS as a
  LEFT OUTER JOIN I_PurchaseOrderItemAPI01 WITH PRIVILEGED ACCESS as b ON ( b~PurchaseOrder = a~PurchaseOrder  ) WHERE
  a~PURCHASEORDER = @<fs_gs1>-purchaseorder  INTO  @DATA(ProductType)  .

  IF
headerdata-documentdate <> '' .
DATA(DAY) = headerdata-documentdate - SY-datum .
DAY = DAY * -1 .

IF DAY > 15 AND SY-uname <> 'CB9980000000'.
APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Please Check Invoice Date'   && |{ DAY }| ) TO messages.
ENDIF.


ENDIF.


**************************gajendra****************


*****************GAJENDRA



*  if  ProductType-PURCHASEORDERTYPE <> 'ZST2' AND ProductType-AccountAssignmentCategory <> 'A'
*  AND producttype-TaxCode <> 'N1'  AND producttype-TaxCode <> 'N2'  AND producttype-TaxCode <> 'N3'
*     AND ( ProductType-PURCHASEORDERTYPE <> 'ZPRJ'
*     OR ( ProductType-PURCHASEORDERTYPE = 'ZPRJ'  AND ProductType-PricingProcedure <> 'ZIMP'  ) ) .
*
**  SELECT SINGLE FiscalYear FROM I_OperationalAcctgDocItem WITH PRIVILEGED ACCESS WHERE OriginalReferenceDocument+0(10) = @<fs_gs1>-referencedocument INTO @DATA(YEAR) .
*
*  select SINGLE AmountInCompanyCodeCurrency from I_JournalEntryItem WITH PRIVILEGED ACCESS where
*  PurchasingDocument = @<fs_gs1>-purchaseorder AND PurchasingDocumentItem = @<fs_gs1>-purchaseorderitem
*  AND SUBSTRING( ReferenceDocumentItem, 3 ,4 ) = @<fs_gs1>-referencedocumentitem
*  AND ReferenceDocument  = @<fs_gs1>-referencedocument
**  AND FiscalYear = @YEAR                                "@<fs_gs1>-referencedocumentfiscalyear
*  AND TransactionTypeDetermination = 'WRX' AND Ledger = '0L'
*
*  AND Plant = @<fs_gs1>-plant into @DATA(TotalGoodsMvtAmtInCCCrcy) .
*
*** IF headerdata-accountingdocumenttype <> 'RE' .
*** ENDIF.
*
*IF SY-subrc <> 0 .
*IF TotalGoodsMvtAmtInCCCrcy = '' OR TotalGoodsMvtAmtInCCCrcy = 0 OR TotalGoodsMvtAmtInCCCrcy = '0.00' .
*
*  select SINGLE  TotalGoodsMvtAmtInCCCrcy from I_MaterialDocumentItem_2 WITH PRIVILEGED ACCESS   where
*  PurchaseOrder = @<fs_gs1>-purchaseorder AND PurchaseOrderItem = @<fs_gs1>-purchaseorderitem
**  AND MaterialDocumentYear = @<fs_gs1>-referencedocumentfiscalyear
*  into @TotalGoodsMvtAmtInCCCrcy .
*
*ENDIF.
*ENDIF.
*
*IF TotalGoodsMvtAmtInCCCrcy < 0 .
*TotalGoodsMvtAmtInCCCrcy = -1 * TotalGoodsMvtAmtInCCCrcy .
*ELSE.
*TotalGoodsMvtAmtInCCCrcy = TotalGoodsMvtAmtInCCCrcy .
*ENDIF.
**  select SINGLE  TotalGoodsMvtAmtInCCCrcy from I_MaterialDocumentItem_2 WITH PRIVILEGED ACCESS where
**  PurchaseOrder = @<fs_gs1>-purchaseorder AND PurchaseOrderItem = @<fs_gs1>-purchaseorderitem
**  AND MaterialDocument = @<fs_gs1>-referencedocument AND MaterialDocumentItem = @<fs_gs1>-referencedocumentitem
**  AND MaterialDocumentYear = @<fs_gs1>-referencedocumentfiscalyear
**  AND Plant = @<fs_gs1>-plant into @TotalGoodsMvtAmtInCCCrcy .
**///////////////////////////////////////////////////////
* IF (  SY-uname <> 'CB9980000021' AND SY-SYSID <> 'Z6L' ) OR ( SY-uname <> 'CB9980000000' AND SY-SYSID = 'Z6L' ).
*
*  IF <fs_gs1>-supplierinvoiceitemamount <> TotalGoodsMvtAmtInCCCrcy.
*  IF headerdata-accountingdocumenttype = 'RE' .
*
*  APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
*                        messageid = 'MRM_BADI_CLOUD'
*                        messagenumber = '001'
*                        messagevariable1 = 'Line Item Amount Not Change .' ) TO messages.
*
*ENDIF.
*  ENDIF.
*  ENDIF.
**//////////////////////////////////////////////////
*  ENDIF.
*  CLEAR:TotalGoodsMvtAmtInCCCrcy.
  ENDLOOP.
* ENDIF.
**********************************************************Line Item Amount Check For Migo********************************

***********************************************************PRD********************************
if headerdata-unplanneddeliverycost > 3000 AND SY-uname <> 'CB9980000000'.

APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Unplanned Delivery Cost Limit Exceed .' ) TO messages.
ENDIF.
loop at itemswithporeference ASSIGNING FIELD-SYMBOL(<fs1>) .


 IF headerdata-postingdate IS NOT INITIAL .

 select SINGLE  PostingDate from I_MaterialDocumentHeader_2 WITH PRIVILEGED ACCESS   where
  MaterialDocument = @<fs1>-referencedocument AND MaterialDocumentYear = @<fs1>-referencedocumentfiscalyear
  into @data(migo_date) .
 if  headerdata-postingdate < migo_date  .

        APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Posting Date is less then Grn Date .' ) TO messages.

 endif .
 ENDIF.
 endloop .

 IF  action = '5' .

 IF  headerdata-postingdate  >  SY-datum .

  APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Posting Date Not Allowed Future Date .' ) TO messages.

 endif .

  IF  headerdata-documentdate  >  SY-datum .

  APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Document Date Not Allowed Future Date .' ) TO messages.

 endif .
***********************************************************PRD********************************

***********************************************************dvlp********************************
 IF SY-SYSID <> 'Z6L'.

loop at itemswithporeference ASSIGNING FIELD-SYMBOL(<GS1>) .
   IF headerdata-postingdate IS NOT INITIAL .

  select SINGLE  PostingDate from I_MaterialDocumentHeader_2 WITH PRIVILEGED ACCESS   where
  MaterialDocument = @<GS1>-referencedocument AND MaterialDocumentYear = @<GS1>-referencedocumentfiscalyear
  into @data(CreationDatedvlp) .
IF SY-subrc <> 0 .
IF CreationDatedvlp = '' .
select SINGLE  PostingDate from I_MaterialDocumentItem_2 WITH PRIVILEGED ACCESS   where
  PurchaseOrder = @<GS1>-purchaseorder AND PurchaseOrderItem = @<GS1>-purchaseorderitem

  into @CreationDatedvlp .
ENDIF.
ENDIF.

 DATA(DAYSdvlp) =  SY-datum - CreationDatedvlp .

   if  DAYSdvlp > 10  .
IF  SY-uname <> 'CB9980000021' .

        APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                         messagevariable1 = 'Bill is extended above 10 days' ) TO messages.
 ENDIF.

 endif .
 ENDIF.
 ENDLOOP.
 ENDIF.
 ENDIF.
***********************************************************dvlp********************************

***********************************************************PRD********************************

 IF SY-SYSID = 'Z6L'.


IF headerdata-accountingdocumenttype   =  'RE' .
IF  action = '5' .

loop at itemswithporeference ASSIGNING FIELD-SYMBOL(<GS2>) .
IF headerdata-postingdate IS NOT INITIAL .

   select SINGLE  PostingDate from I_MaterialDocumentHeader_2 WITH PRIVILEGED ACCESS   where
   MaterialDocument = @<GS2>-referencedocument AND MaterialDocumentYear = @<GS2>-referencedocumentfiscalyear
   into @data(CreationDatePRD) .

IF SY-subrc <> 0 .
IF CreationDatePRD = '' OR  CreationDatePRD =  00000000 OR  CreationDatePRD IS INITIAL  OR  CreationDatePRD =  '00000000' .

select SINGLE  PostingDate from I_MaterialDocumentItem_2 WITH PRIVILEGED ACCESS   where
  PurchaseOrder = @<GS2>-purchaseorder AND PurchaseOrderItem = @<GS2>-purchaseorderitem
  into @CreationDatePRD.

ENDIF.
ENDIF.



 DATA(DAYSPRD) =  SY-datum - CreationDatePRD .

   if  DAYSPRD > 10  .
IF  SY-uname <> 'CB9980000000' .

        APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                         messagevariable1 = 'Bill is extended above 10 days' ) TO messages.
 ENDIF.

 endif .
 ENDIF.
 ENDLOOP.


 IF headerdata-invoicegrossamount BETWEEN  '0' AND '3000000' .
 IF SY-uname = 'CB9980000212' OR SY-uname = 'CB9980000036' or  SY-uname = 'CB9980000000' .

 ELSE .
  APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'You Have No Authorization To Post This Invoice' ) TO messages.

 ENDIF.
 ELSEIF  headerdata-invoicegrossamount >  '3000000'  .

 IF  SY-uname = 'CB9980000000' OR SY-uname = 'CB9980000036'  .

 ELSE.
  APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'You Have No Authorization To Post This Invoice' ) TO messages.
 ENDIF.

ENDIF.
ENDIF.
ENDIF.
ENDIF.

***********************************************************PRD********************************

   IF headerdata-businessplace = '' .

   APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'BusinessPlace Field Mandatory' ) TO messages.
  ENDIF.

   IF headerdata-supplierinvoiceidbyinvcgparty = '' .

   APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Reference Field Mandatory' ) TO messages.
  ENDIF.
***********************premsingh
IF  action = 'D' .
IF SY-uname <> 'CB9980000000' .
**IF  SY-uname <> 'CB9980000000' or SY-uname <> 'CB9980000013' .
 APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'You are not authorized for delete park document' ) TO messages.
  ENDIF.
  ENDIF.
**********************premsingh


IF  action <> 'D' .

   Select SINGLE  SupplierInvoice from I_SupplierInvoiceAPI01 WITH PRIVILEGED ACCESS   where
   FiscalYear = @<fs1>-referencedocumentfiscalyear AND CompanyCode = @headerdata-companycode
   AND SupplierInvoiceIDByInvcgParty = @headerdata-supplierinvoiceidbyinvcgparty AND InvoicingParty = @headerdata-invoicingparty
   AND ReverseDocument = '' AND AccountingDocumentType = @headerdata-accountingdocumenttype
  into @data(ParckCheck) .

  IF SY-subrc = 0 .
  IF ParckCheck <> '' AND Headerdata-supplierinvoice NE ParckCheck AND Headerdata-supplierinvoice <> ' ' .
   APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Invoice Already Created' ) TO messages.
  ENDIF.
  ENDIF.



  IF headerdata-supplierpostinglineitemtext = '' AND headerdata-reversedocument = ''.

   APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Text Field Mandatory' ) TO messages.
  ENDIF.

   READ TABLE ITEMSWITHPOREFERENCE INTO DATA(WA_ITEM) INDEX 1.
   DATA MAT TYPE C LENGTH 3.
   MAT  =   WA_ITEM-purchaseorderitemmaterial+0(3) .
     IF MAT IS NOT INITIAL .
     SELECT SINGLE description FROM zfi_material_tmg  WHERE material = @MAT INTO @DATA(MATCHECK).
     IF SY-subrc = 0 .
     IF headerdata-supplierpostinglineitemtext <> ' '  OR headerdata-supplierpostinglineitemtext is NOT INITIAL OR headerdata-supplierpostinglineitemtext  NE ' ' .
     IF MATCHECK <> '' AND MATCHECK NE headerdata-supplierpostinglineitemtext .
      APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Input Text WRong' ) TO messages.
     ENDIF.
     ENDIF.
     ENDIF.
     ELSEIF MAT IS  INITIAL .

     SELECT SINGLE description FROM zfi_material_tmg  WHERE description = @headerdata-supplierpostinglineitemtext INTO @MATCHECK.
     IF SY-subrc <> 0 .
     IF MATCHECK = '' OR MATCHECK NE headerdata-supplierpostinglineitemtext .
      APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'Input Text WRong' ) TO messages.

     ENDIF.
     ENDIF.
     ENDIF.
     ENDIF.

     IF WA_ITEM-plant = '1200' AND SY-uname = 'CB9980000060'  .
      APPEND VALUE #( messagetype = if_ex_mrm_check_invoice_cloud=>c_messagetype_error
                        messageid = 'MRM_BADI_CLOUD'
                        messagenumber = '001'
                        messagevariable1 = 'YOU ARE NOT AUTHORIZED FOR THIS TRANSACTION' ) TO messages.

     ENDIF.





   ENDMETHOD.
ENDCLASS.
