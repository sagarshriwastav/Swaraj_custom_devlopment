@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Gst Data invoice'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity y_gstdatainv as select from I_BillingDocumentItemPrcgElmnt as A 
 {             
key A.BillingDocument ,
key  A.BillingDocumentItem,
 A.TransactionCurrency ,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 sum( A.ConditionAmount ) as TaxableValue 
}
where A.ConditionType = 'JOIG' or 
      A.ConditionType = 'JOSG' or 
      A.ConditionType = 'JOCG' or 
      A.ConditionType = 'JOUG'      
group by 
A.BillingDocument ,
A.BillingDocumentItem ,
A.TransactionCurrency
