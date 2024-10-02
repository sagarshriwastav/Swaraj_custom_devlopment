@AbapCatalog.sqlViewName: 'YOPEN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR OPENING'
define view ZPP_SAMPLING_REP_OPENING1 
 with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
  as select from I_MaterialStock_2
{
 key Material,
 key Plant,
 key StorageLocation,
 key Batch,
  CompanyCode,
  MaterialBaseUnit,
 // MatlDocLatestPostgDate ,
  
  
  sum( MatlWrhsStkQtyInMatlBaseUnit )   as MatlWrhsStkQtyInMatlBaseUnit
}
where
      MatlDocLatestPostgDate <= $parameters.P_KeyDate // and  MatlWrhsStkQtyInMatlBaseUnit > 0
 and    MatlDocLatestPostgDate <= dats_add_days ($parameters.P_KeyDate,-1,'UNCHANGED')


group by
  Material,
  Plant,
  StorageLocation,
  Batch,
  CompanyCode,
  MaterialBaseUnit
