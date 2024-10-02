@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPRODUCTION_SUMMARY_CDS2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPRODUCTION_SUMMARY_CDS2 as select from ZPRODUCTION_SUMMARY_CDS1
{
    key PostingDate,
    MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    Warpingproduction,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    Dyeingproduction,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    Weavingproduction,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    Finishingproduction,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    Greadingproduction,
   ( Dyeingproduction / 22 / 60 ) as AveragepermtrDyeingprod 
}
