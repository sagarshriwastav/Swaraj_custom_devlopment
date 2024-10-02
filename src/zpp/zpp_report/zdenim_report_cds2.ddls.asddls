@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZDENIM_REPORT_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDENIM_REPORT_CDS2 as select from I_MaterialDocumentItem_2 as A
{
   A.Batch,
   A.GoodsMovementType,
   A.StorageLocation,
   A.IssuingOrReceivingStorageLoc,
   A.Material,
   A.EntryUnit,
   A.GoodsMovementIsCancelled,
    @Semantics.quantity.unitOfMeasure: 'EntryUnit'
    
    A.QuantityInEntryUnit  as Quantity
   
   
   
   
}
where (A.GoodsMovementType = '311' or A.GoodsMovementType = '312') and A.StorageLocation = 'FRC1 ' and A.IssuingOrReceivingStorageLoc = 'INS1'
        and A.GoodsMovementIsCancelled = '' and A.DebitCreditCode = 'S'

//   group by
//   A.Batch,
//   A.GoodsMovementType,
//   A.StorageLocation,
//   A.IssuingOrReceivingStorageLoc,
//   A.Material,
//   A.EntryUnit,
//    A.GoodsMovementIsCancelled
   
   
