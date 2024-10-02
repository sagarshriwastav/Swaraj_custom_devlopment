@AbapCatalog.sqlViewName: 'ZISSUESEM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Sampling Report Issue'
define view ZPP_SAMPLING_ISSUE1
 with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from ZPP_SAMPLING_REP_ISSUE( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )
{
  key Material,
  key Plant,
  key StorageLocation,   
  key Batch,
      sum( Issue )       as Issue,
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
