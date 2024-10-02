@AbapCatalog.sqlViewName: 'YRECEIPT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FOR RECEIPT'
define view ZPP_SAMPLING_REP_RECEIPT1 
with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from ZPP_SAMPLING_REP_DATE( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate )
{
  key Material,
  key Plant,
  key StorageLocation,   
  key Batch,
      sum( Receipt )     as Receipt,
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
