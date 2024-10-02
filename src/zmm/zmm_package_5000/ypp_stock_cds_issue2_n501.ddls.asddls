@AbapCatalog.sqlViewName: 'Y501ISSUE2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Stock Report 501 As On Date'
define view YPP_STOCK_CDS_ISSUE2_N501 with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
    as select from YPP_STOCK_CDS_ISSUE_N501( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )
{
  key Material,
  key Plant,
  key StorageLocation,
  key Batch,
      sum( Receipt )     as Receipt,
      sum( RevReceipt )  as RevReceipt,
      MaterialBaseUnit
}
where
      PostingDate >= $parameters.p_fromdate
  and PostingDate <= $parameters.p_todate
group by
  Plant,
  Material,
  StorageLocation,
   Batch,
  MaterialBaseUnit
