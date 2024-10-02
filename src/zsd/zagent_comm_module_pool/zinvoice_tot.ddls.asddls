@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Tot'
define root view entity ZINVOICE_TOT
  as select from I_BillingDocumentItem

{
  key BillingDocument,
      BillingQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
      sum( BillingQuantity ) as bill_qty
}
group by
  BillingDocument,
  BillingQuantityUnit
