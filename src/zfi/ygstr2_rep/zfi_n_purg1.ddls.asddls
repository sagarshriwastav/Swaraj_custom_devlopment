@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YGSTR2_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_N_Purg1 as select from YGSTR99 as a inner join                       
//define view entity ZFI_N_Purg as select from YGSTR99 as a inner join 
       I_OperationalAcctgDocItem as b on a.FiDocumentItem = b.TaxItemAcctgDocItemRef and a.FiDocument = b.AccountingDocument
       and b.PurchasingDocument is not initial  and b.CompanyCode = a.CompanyCode and b.FiscalYear = a.FiscalYear

{
    key a.FiDocument,
    key a.FiscalYear,
    key a.CompanyCode,
    a.FiDocumentItem,
    a.DocumentDate,
    a.TransactionCurrency  ,
    a.Mironumber,
    a.MiroYear,
    a.Refrence_No,
    a.AccountingDocumentType,
     @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.InvoceValue ,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.TaxableValue,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.Gross_amount,
    a.TaxCode,   
   @Semantics.amount.currencyCode: 'TransactionCurrency'  
     a.igst                      as IGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.cgst                      as CGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.Sgst                      as SGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
     a.RCM_igst                 as RCMI,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.RCM_cgst                   as RCMC,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.RCM_Sgst                   as RCMS,
    a.PARTYcODE,
    a.PlaceofSupply,
    a.PartyName,
    a.GstIn,
    a.State,
    a.TaxRate ,
    b.PurchasingDocument ,
    b.PurchasingDocumentItem ,
    b.Product ,
    b.IN_HSNOrSACCode as HsnCode,
    b.PostingDate,
    
//     ,
//   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'   
   @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    b.Quantity as poquantity,
    b.BaseUnit
    
}
 
