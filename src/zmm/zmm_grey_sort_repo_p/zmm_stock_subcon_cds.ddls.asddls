@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STOCK SUBCON CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_STOCK_SUBCON_CDS as select from ZMM_STOCK_SUBCONTRACTOR_CDS2 as A
{
  A.Greyshort,
  A.Batch ,
  A.MaterialBaseUnit,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  A.MatlWrhsStkQtyInMatlBaseUnit
    
} 
