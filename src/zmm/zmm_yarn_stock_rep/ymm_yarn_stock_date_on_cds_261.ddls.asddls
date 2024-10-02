@AbapCatalog.sqlViewName: 'YMMISSUE261'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Stock Report Date on 261'
define view  YMM_YARN_STOCK_DATE_ON_CDS_261 with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from I_MaterialDocumentItem_2
{
  key Material,
  key Plant,
  key StorageLocation,
  key Batch,
  
      case when GoodsMovementType = '261' or GoodsMovementType = '311' or GoodsMovementType = '301'
         then sum( QuantityInBaseUnit ) end as Issue,
      case when GoodsMovementType = '262'or  GoodsMovementType = '312' or GoodsMovementType = '302' 
      then sum( QuantityInBaseUnit ) end as RevIssue,
      MaterialBaseUnit,
      PostingDate
} 
where 
       ( GoodsMovementType = '261' or GoodsMovementType = '262' or GoodsMovementType = '311' or 
       GoodsMovementType = '312' or GoodsMovementType = '302' or 
      GoodsMovementType = '301' ) 
    //     Material like 'Y%'
    and  Batch != '' and
   PostingDate > $parameters.p_fromdate
  and PostingDate <= $parameters.p_todate
//  and QuantityInBaseUnit = '0.000' 
group by
  Plant,
  Material,
  StorageLocation,
  Batch,
  GoodsMovementType,
  MaterialBaseUnit,
  PostingDate
