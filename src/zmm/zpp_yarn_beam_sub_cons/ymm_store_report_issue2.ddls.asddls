@AbapCatalog.sqlViewName: 'YMM_STORE_ISSUE2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM Store Issue'
define view YMM_STORE_REPORT_ISSUE2
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from YMM_STOCK_REPORT_ISSUE( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )
{
  key Material,
  key Plant,
  key Batch,
     Supplier,
      sum( Issue )          as Issue,
      sum( RestunQty ) as   RestunQty,
      sum( Consumption ) as Consumption,
      MaterialBaseUnit
}
where
      PostingDate > $parameters.p_fromdate
  and PostingDate <= $parameters.p_todate
group by
  Plant,
  Batch,
  Supplier,
  Material,
  MaterialBaseUnit
