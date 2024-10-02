@AbapCatalog.sqlViewName: 'YMMISSUEN261'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Stock Report Date on 261'
define view YMM_YARN_STOCK_CDS_261_N with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from YMM_YARN_STOCK_DATE_ON_CDS_261( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )
{
  key Material,
  key Plant,
  key StorageLocation,
  key Batch,

      sum(Issue)       as Issue,
      sum(RevIssue)    as RevIssue,

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
