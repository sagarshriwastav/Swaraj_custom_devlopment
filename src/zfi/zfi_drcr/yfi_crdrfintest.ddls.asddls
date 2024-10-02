@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fi Credit Debit Note'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YFI_CRDRfintest as select from I_OperationalAcctgDocItem {
    key CompanyCode,
    key AccountingDocument,
    key FiscalYear,
    key AccountingDocumentItem,
    TaxItemAcctgDocItemRef as txgrp,
    AccountingDocumentItemType ,
    CompanyCodeCurrency,
    DocumentDate ,
    InvoiceReference,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    AmountInCompanyCodeCurrency as amt ,
    Product,
    PurchasingDocument ,
    BaseUnit,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    PurchaseOrderQty ,
    PurchasingDocumentItem ,
    TaxCode ,
    DocumentItemText,
    WithholdingTaxCode,
    IN_HSNOrSACCode,
    TaxItemAcctgDocItemRef 
    

} where 
//AccountingDocument  = '5100000087' 
 TaxItemAcctgDocItemRef is not initial
 and   AccountingDocumentItemType != 'T' 
