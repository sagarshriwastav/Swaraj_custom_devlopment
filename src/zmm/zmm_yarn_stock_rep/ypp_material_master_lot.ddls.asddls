@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Stock Report Date on'
define root view entity ypp_material_master_lot as select from I_MaterialDocumentItem_2 
{
 key Material,
 key Plant,
 key StorageLocation,
 Batch,
 GoodsMovementType,
 MaterialBaseUnit,
 PostingDate
} where Batch != ''  and ( GoodsMovementType = '101' or GoodsMovementType = '561'or GoodsMovementType = '261' or
         GoodsMovementType = '301'or GoodsMovementType = '311' 
  )  and ( Material like 'Y%'  )
