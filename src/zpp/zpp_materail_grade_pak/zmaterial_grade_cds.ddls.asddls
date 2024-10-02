@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR MATERIAL_GRADE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMATERIAL_GRADE_CDS as select from zpp_finishing  as A
left outer join I_MaterialDocumentItem_2 as B on (  B.Material = A.material101 and B.Batch = A.finishrollno )
    and (  B.StorageLocation = 'INS1'  or B.IssuingOrReceivingStorageLoc = 'FRC1' ) and ( B.GoodsMovementType = '311' )
  
      //or  B.IssuingOrReceivingStorageLoc = 'FRC1'
      
{ 
 key A.material101,
 key  A.postingdate as postingdatefini, 
      A.materialdocument101,
      cast('M' as abap.unit( 3 ) ) as zunit,
      @Semantics.quantity.unitOfMeasure : 'zunit'
      A.finishmtr,
      A.shrinkageperc,
      A.plant,
       @Semantics.quantity.unitOfMeasure : 'zunit'
      A.greigemtr,
      B.StorageLocation,
      B.IssuingOrReceivingStorageLoc,
//      A.postingdate as postingdatefini, 
     
      B.MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   sum( B.QuantityInBaseUnit  )as QTY
//       @Semantics.quantity.unitOfMeasure: 'zunit'
//        sum(B.QuantityInEntryUnit) as QTY
  
      
      
    
    
}  where B.GoodsMovementIsCancelled = ' '  
  //where (  B.StorageLocation = 'INS1'  or  B.IssuingOrReceivingStorageLoc = 'FRC1' ) and (B.GoodsMovementIsCancelled = ' '
 //    and B.GoodsMovementType = '311' )
group by A.material101,
      A.finishmtr,
      A.shrinkageperc,
      A.plant,
      A.materialdocument101,
      A.greigemtr,
      B.MaterialBaseUnit,
//      B.QuantityInBaseUnit,
      A.postingdate,
       B.StorageLocation,
      B.IssuingOrReceivingStorageLoc
