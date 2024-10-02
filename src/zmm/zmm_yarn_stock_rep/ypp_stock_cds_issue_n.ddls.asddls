@AbapCatalog.sqlViewName: 'YMMISSUE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Stock Report Date on'
define view YPP_STOCK_CDS_ISSUE_N with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from I_MaterialDocumentItem_2  as a
 
{
  key a.Material,
  key a.Plant,
  key a.StorageLocation,
  key a.Batch,
      case when a.GoodsMovementType = '101' or a.GoodsMovementType = '561'  then sum( a.QuantityInBaseUnit ) end as Receipt,
      case when a.GoodsMovementType = '102' or a.GoodsMovementType = '562' then sum( a.QuantityInBaseUnit ) end as RevReceipt,
      
      case when GoodsMovementType = '261' or GoodsMovementType = '311' or GoodsMovementType = '301'
      then sum( QuantityInBaseUnit ) end as Issue,
      case when GoodsMovementType = '262'or  GoodsMovementType = '312' or GoodsMovementType = '302' 
      then sum( QuantityInBaseUnit ) end as RevIssue,
      a.MaterialBaseUnit,
      a.PostingDate
}
where 
 //     Material like 'Y%'
     a.Batch != '' and
   a.PostingDate > $parameters.p_fromdate
  and a.PostingDate <= $parameters.p_todate
//  and QuantityInBaseUnit = '0.000' 
group by
  a.Plant,
  a.Material,
  a.StorageLocation,
  a.Batch,
  a.GoodsMovementType,
  a.MaterialBaseUnit,
  a.PostingDate
