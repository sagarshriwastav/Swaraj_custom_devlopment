@AbapCatalog.sqlViewName: 'Y510REC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Stock Report 501 As On Date'
define view YPP_STOCK_CDS_ISSUE_N501 with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from I_MaterialDocumentItem_2  as a
 
{
  key a.Material,
  key a.Plant,
  key a.StorageLocation,
  key a.Batch,
      case when a.GoodsMovementType = '501'  then sum( a.QuantityInBaseUnit ) end as Receipt,
      case when a.GoodsMovementType = '502'  then sum( a.QuantityInBaseUnit ) end as RevReceipt,
   
      a.MaterialBaseUnit,
      a.PostingDate
}
where 
 //     Material like 'Y%'
     a.Batch != '' and
   a.PostingDate >= $parameters.p_fromdate
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
