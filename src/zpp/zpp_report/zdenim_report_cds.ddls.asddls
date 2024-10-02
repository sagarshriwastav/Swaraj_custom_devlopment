@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZDENIM_REPORT_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDENIM_REPORT_CDS as select from I_MaterialDocumentItem_2 as A
{
   A.Batch,
   A.MaterialDocument,
   A.MaterialDocumentItem,
   A.GoodsMovementType,
   A.StorageLocation,
   A.Material,
   A.EntryUnit,
   A.GoodsMovementIsCancelled,
    @Semantics.quantity.unitOfMeasure: 'EntryUnit'
    
   sum( A.QuantityInEntryUnit ) as Quantity
   
   
   
   
}
where A.GoodsMovementType = '311' 
        and A.GoodsMovementIsCancelled = ''

   group by
   A.Batch,
   A.GoodsMovementType,
      A.MaterialDocument,
   A.MaterialDocumentItem,
   A.StorageLocation,
   A.Material,
   A.EntryUnit,
    A.GoodsMovementIsCancelled
   
   
