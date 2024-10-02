@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_WEFT_CONSUMPTION_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_WEFT_CONSUMPTION_QTY as select from I_MaterialDocumentItem_2
{
    key MaterialDocument,
    key MaterialDocumentItem,
        Batch,
    MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(QuantityInBaseUnit) as QuantityInBaseUnit
    
}where GoodsMovementIsCancelled = ''
    and GoodsMovementType = '543'
    and InventorySpecialStockType = 'F'
    and Plant = '1200'
    
 group by  MaterialDocument,
    MaterialDocumentItem,
    MaterialBaseUnit,
    Batch
