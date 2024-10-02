@AbapCatalog.sqlViewName: 'YSMPL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_SAMPLING_REPORT'
define view ZPP_SAMPLING_REPORT 
     
as select from I_MaterialDocumentItem_2
 {
 key Material,
 key Plant,
 key StorageLocation,
 key Batch,
 MaterialBaseUnit ,
 PostingDate
} where Batch != ''  
  and ( GoodsMovementType = '201' or GoodsMovementType = '261' or GoodsMovementType = '311' 
  or    GoodsMovementType = '312'or GoodsMovementType = '411' or GoodsMovementType = '412'or GoodsMovementType = '413' or GoodsMovementType = '561'
  or    GoodsMovementType = '601'or GoodsMovementType = '602' or GoodsMovementType = '562' or GoodsMovementType = '101' )  
  and   StorageLocation like 'SA01%' 
 // and   StorageLocation != IssuingOrReceivingStorageLoc 

  group by 
     Material,
     Plant,
     StorageLocation,
     Batch,
     MaterialBaseUnit ,
     PostingDate
      
  
