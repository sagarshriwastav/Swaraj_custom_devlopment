@AbapCatalog.sqlViewName: 'YEXPORTGST2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1'
define view YGSTR1_EXPORT_2 as select from YGSTR1_EXPORT_1 as A
{ 
 key A.BillingDocument, 
  A.TransactionCurrency,      
  @Semantics.amount.currencyCode: 'TransactionCurrency'  
  sum(A.FREIGHT_OCEAN) as FREIGHT_OCEAN,     
  @Semantics.amount.currencyCode: 'TransactionCurrency'  
  sum(A.EXPORT_INS) as EXPORT_INS    
       
} 
group by 
A.BillingDocument,
A.TransactionCurrency
