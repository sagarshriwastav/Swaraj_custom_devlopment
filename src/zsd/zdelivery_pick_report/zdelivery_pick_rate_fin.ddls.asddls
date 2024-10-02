@AbapCatalog.sqlViewName: 'YSUMEERYPCKRATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Delivery Pick Rate'
define view ZDELIVERY_PICK_RATE_fin as select from ZDELIVERY_PICK_RATE as A
 left outer join ZDELIVERY_PICK_RATE_cds2 as D on ( D.DeliveryDocument = A.DeliveryDocument 
                                                and D.DELIVERYDOCUMENTITEM = A.DELIVERYDOCUMENTITEM 
                                                and D.Plant = A.Plant 
                                                and D.Material = A.Material ) 
{
  key A.DeliveryDocument,
  key A.DELIVERYDOCUMENTITEM,
  A.Plant,
  A.Material,
  A.DeliveryDocumentItemText,
  A.BaseUnit,
  A.Batch,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  A.DELIVERY_QTY,
  A.TransactionCurrency,
   @Semantics.amount.currencyCode: 'TransactionCurrency'
  A.PICKRATE,
  A.pick,
   @Semantics.amount.currencyCode: 'TransactionCurrency'
  A.amt,
  @Semantics.quantity.unitOfMeasure: 'BaseUnit'
  D.DeliveryQty  as summeryDeliveryQty,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
  D.PickRAteAmt  as summeryPickRAteAmt
}
