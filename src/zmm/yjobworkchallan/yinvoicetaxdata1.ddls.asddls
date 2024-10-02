@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice tax data Gst'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity yinvoicetaxdata1 as select from  YINVOICETAXDATA_3 as a
 {                                                                                       
key a.BillingDocument ,
key a.BillingDocumentItem,
 a.TransactionCurrency ,
 a.BaseUnit,
 @Semantics.quantity.unitOfMeasure: 'BaseUnit'
 sum(a.BillingQuantity) as BillingQuantity,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 a.TaxableValue  ,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
  a.taxvalue,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
 sum( a.ConditionAmount ) as TotalInvoiceValue ,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(a.TOTALBASICAMOUNT) as TOTALBASICAMOUNT,
// C.ConditionType,
 a.PaymentTermsDescription,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 a.StandardPrice,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
//( (A.BillingQuantity) * h.StandardPrice ) as 
 a.AMOUNT
 
} group by 
a.BillingDocument ,
a.BillingDocumentItem ,
a.BaseUnit,
//a.BillingQuantity,
//C.ConditionType,
a.TransactionCurrency ,
a.taxvalue,
a.TaxableValue
,
a.PaymentTermsDescription,
a.StandardPrice,
//a.TOTALBASICAMOUNT,
a.AMOUNT
//A.BillingQuantity
