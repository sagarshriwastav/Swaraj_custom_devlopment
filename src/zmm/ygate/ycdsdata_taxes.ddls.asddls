@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds data for ddition multiple Conditions'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YCDSData_Taxes as select from  I_BillingDocument  as b 
   left outer join I_BillingDocumentItemPrcgElmnt as A on ( b.BillingDocument = A.BillingDocument )
 {             
key A.BillingDocument ,
key A.BillingDocumentItem,
 A.TransactionCurrency ,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 sum( A.ConditionAmount ) as TaxableValue 
}
where 
      A.ConditionType = 'ZBAS' or 
      A.ConditionType = 'ZD03' or
      A.ConditionType = 'ZI01' or 
      A.ConditionType = 'ZI02' or 
      A.ConditionType = 'ZP01' or 
      A.ConditionType = 'ZP02' or 
      A.ConditionType = 'ZPOS' or
      A.ConditionType = 'ZC01' or
      A.ConditionType = 'ZR00' or 
      A.ConditionType = 'ZCHD' or 
      A.ConditionType = 'ZD05'
      
        
group by 
A.BillingDocument ,
A.BillingDocumentItem ,
A.TransactionCurrency
