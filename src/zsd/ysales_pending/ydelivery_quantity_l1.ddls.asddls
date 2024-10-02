@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery Quantity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YDELIVERY_QUANTITY_L1
  as select from I_DeliveryDocumentItem as a
{
  a.ReferenceSDDocument,
  a.ReferenceSDDocumentItem,
  a.Plant,
  a.Product,
  a.TransactionCurrency,
  a.BaseUnit as DeliveryQuantityUnit,
  @Semantics.quantity.unitOfMeasure: 'DeliveryQuantityUnit'
  sum( a.ActualDeliveryQuantity ) as Delivery_Quantity
}
group by
  a.ReferenceSDDocument,
  a.ReferenceSDDocumentItem,
  a.Plant,
  a.Product,
  a.TransactionCurrency,
  a.BaseUnit
