@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YGSTR2_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_N_Purg as select from YGSTR2 as a inner join                       
//define view entity ZFI_N_Purg as select from YGSTR99 as a inner join 
       I_OperationalAcctgDocItem as b on a.FiDocumentItem = b.TaxItemAcctgDocItemRef and a.FiDocument = b.AccountingDocument
       and b.PurchasingDocument is not initial  and b.CompanyCode = a.CompanyCode and b.FiscalYear = a.FiscalYear and b.TransactionTypeDetermination = 'WRX'
  left outer join ZPRICING_CDS as C on (  C.PurchaseOrder = b.PurchasingDocument and C.PurchaseOrderItem = b.PurchasingDocumentItem  )
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
     sum(a.igst)                      as IGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.cgst)                      as CGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.Sgst)                      as SGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
     sum(a.RCM_igst)                 as RCMI,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.RCM_cgst)                   as RCMC,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.RCM_Sgst)                   as RCMS,
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
//    C.PurchaseOrder,
//    C.PurchaseOrderItem,
    C.ConditionCurrency,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    C.ConditionAmountZF,
     @Semantics.amount.currencyCode: 'ConditionCurrency'
    C.ConditionAmountZP,
     @Semantics.amount.currencyCode: 'ConditionCurrency'
    C.ConditionAmountZL,
     @Semantics.amount.currencyCode: 'ConditionCurrency'
    C.ConditionAmountZI,
     @Semantics.amount.currencyCode: 'ConditionCurrency'
    C.ConditionAmountZOT,
     @Semantics.amount.currencyCode: 'ConditionCurrency'
    C.ConditionAmount_ZMND,
     @Semantics.amount.currencyCode: 'ConditionCurrency'
    C.ConditionAmount_ZROL,
     @Semantics.amount.currencyCode: 'ConditionCurrency'
    C.ConditionAmount_ZJIL,
  //  C.ConditionCurrency,
//     @Semantics.amount.currencyCode: 'ConditionCurrency'
//    C.ConditionAmount as FRIEGHT_CHARGES,
    
//     ,
//   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'   
   @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    b.Quantity as poquantity,
    b.BaseUnit
    
}
  group by
  
    a.FiDocument,
    a.FiscalYear,
    a.CompanyCode,
    a.FiDocumentItem,
    a.DocumentDate,
    a.TransactionCurrency  ,
    a.Mironumber,
    a.MiroYear,
    a.Refrence_No,
    a.AccountingDocumentType,
    a.InvoceValue ,
    a.TaxableValue,
    a.Gross_amount,
    a.TaxCode, 
    a.PARTYcODE,
    a.PlaceofSupply,
    a.PartyName,
    a.GstIn,
    a.State,
    a.TaxRate ,
    b.PurchasingDocument ,
    b.PurchasingDocumentItem ,
    b.Product ,
    b.IN_HSNOrSACCode ,
    b.PostingDate,
    b.Quantity ,
    b.BaseUnit,
    C.ConditionCurrency,
     C.ConditionAmountZF,
    C.ConditionAmountZP,
    C.ConditionAmountZL,
    C.ConditionAmountZI,
    C.ConditionAmountZOT,
    C.ConditionAmount_ZMND,
    C.ConditionAmount_ZROL,
    C.ConditionAmount_ZJIL
    
   
 
