@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_WARPING_SUM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMIS_WARPING_SUM as select from  I_MaterialDocumentItem_2 as d 
  
{
      d.Batch,
      cast( 'M' as abap.unit( 3 ) ) as MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
      sum(d.QuantityInBaseUnit) as WarpingLength
      
      
}where d.GoodsMovementType = '101' and d.Material like 'BW%'
    and d.GoodsMovementIsCancelled = ''
    
    group by d.Batch
