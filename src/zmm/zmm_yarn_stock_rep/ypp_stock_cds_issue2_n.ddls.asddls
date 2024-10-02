@AbapCatalog.sqlViewName: 'YMMISSUEN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Stock Report Date on'
define view YPP_STOCK_CDS_ISSUE2_N with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from YPP_STOCK_CDS_ISSUE_N( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )
{
  key Material,
  key Plant,
  key StorageLocation,
  key Batch,
      sum( Receipt )     as Receipt,
      sum( RevReceipt )  as RevReceipt,
      sum( Issue )       as Issue,
      sum( RevIssue )    as RevIssue,
      MaterialBaseUnit
}
where
      PostingDate > $parameters.p_fromdate
  and PostingDate <= $parameters.p_todate
group by
  Plant,
  Material,
  StorageLocation,
   Batch,
  MaterialBaseUnit
