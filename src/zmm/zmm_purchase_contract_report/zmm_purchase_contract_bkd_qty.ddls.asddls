@AbapCatalog.sqlViewName: 'YBOOKEDQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase Contract Booked Quantity'
define view ZMM_PURCHASE_CONTRACT_BKD_QTY as select from I_PurchaseContractItemAPI01
{
    key PurchaseContract,
        OrderPriceUnit,
        @Semantics.quantity.unitOfMeasure: 'OrderPriceUnit'
        sum(TargetQuantity) as TargetQuantity


}
  where  PurchasingContractDeletionCode = ' ' and PurchaseContractItem <> '00010'
    group by 
       PurchaseContract,
       OrderPriceUnit
