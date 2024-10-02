@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPRODUCTION_SUMMARY_CDS1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPRODUCTION_SUMMARY_CDS1 as select from I_MaterialDocumentItem_2
{
    key PostingDate,
        MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      //  QuantityInBaseUnit,
        sum( case when GoodsMovementType = '101' and Material like 'BW%' 
        and StorageLocation = 'WRP1' then QuantityInBaseUnit end ) as  Warpingproduction ,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum( case when GoodsMovementType = '101' and Material like 'BD%'
        and StorageLocation = 'DY01' then QuantityInBaseUnit end ) as  Dyeingproduction,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum( case when GoodsMovementType = '101' and Material like 'FGO%'
        and StorageLocation = 'PH01' then QuantityInBaseUnit end ) as  Weavingproduction,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum( case when GoodsMovementType = '101' and StorageLocation = 'FN01'
        then QuantityInBaseUnit end ) as  Finishingproduction,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum( case when GoodsMovementType = '311' and StorageLocation = 'INS1'
        and IssuingOrReceivingStorageLoc = 'FG01' then QuantityInBaseUnit end )
         as  Greadingproduction
               
        
} where GoodsMovementIsCancelled = '' and MaterialBaseUnit like 'M'
 group by PostingDate,
          MaterialBaseUnit

