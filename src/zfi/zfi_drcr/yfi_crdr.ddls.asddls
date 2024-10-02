@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fi Credit Debit Note'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Yfi_crdr as select from I_OperationalAcctgDocItem {
    key CompanyCode,
    key AccountingDocument,
    key FiscalYear,
  //  key AccountingDocumentItem,
    TaxItemAcctgDocItemRef as txgrp,
 //   AccountingDocumentItemType ,
    CompanyCodeCurrency,
    PostingDate,
    DocumentDate ,
    InvoiceReference,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(AmountInCompanyCodeCurrency) as amt ,
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
  //  GLAccount
    

} where 
//AccountingDocument  = '5100000087' 
 TaxItemAcctgDocItemRef is not initial
 and   AccountingDocumentItemType != 'T'
 and GLAccount <> '3500001050'  and GLAccount <> '4500009010' 
 group by 
     CompanyCode,
     AccountingDocument,
     FiscalYear,
  //  key AccountingDocumentItem,
    TaxItemAcctgDocItemRef ,
 //   AccountingDocumentItemType ,
    CompanyCodeCurrency,
    PostingDate,
    DocumentDate ,
    InvoiceReference,
    Product,
    PurchasingDocument ,
    BaseUnit,
    PurchaseOrderQty ,
    PurchasingDocumentItem ,
    TaxCode ,
    DocumentItemText,
    WithholdingTaxCode,
    IN_HSNOrSACCode,
    TaxItemAcctgDocItemRef 
