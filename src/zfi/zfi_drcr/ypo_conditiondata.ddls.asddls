@AbapCatalog.sqlViewName: 'ZASD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YPO_CONDITIONDATA'
define view YPO_CONDITIONDATA as select from I_PurOrdItmPricingElementAPI01
 {
    key PurchaseOrder,
    key PurchaseOrderItem,

TransactionCurrency,
@Semantics.amount.currencyCode: 'TransactionCurrency'
   sum( ConditionAmount ) as GROSSAMT
} group by 
 PurchaseOrder,
    PurchaseOrderItem,
    PricingDocument,
 
     TransactionCurrency
