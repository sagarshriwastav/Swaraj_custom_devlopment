@AbapCatalog.sqlViewName: 'YPENWISE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Facory Beam Print'
define view ZMM_Yarn_Factory_Beam_OPEN with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
  as select from I_MaterialStock as a 
  left outer join I_MaterialDocumentItem_2 as b on (b.Material = a.Material 
                                                    and b.Batch = a.Batch 
                                                    and b.Plant = a.Plant 
                                                    and b.GoodsMovementType = '501' )
{
  a.Plant,
  b.Customer,
  sum( a.MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit
}
where
  MatlDocLatestPostgDate <= dats_add_days ($parameters.P_KeyDate,-1,'UNCHANGED')
  and a.Material not like 'BDJ%' and a.Material not like 'BDJL%' 
 // MatlDocLatestPostgDate <= $parameters.P_KeyDate 
group by
  a.Plant,
  b.Customer
