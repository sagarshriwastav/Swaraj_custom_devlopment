@AbapCatalog.sqlViewName: 'YCLOSEQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Facory Beam Qty'
define view Yarn_Factory_Beam_CLOSE with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
  as select from I_MaterialStock as a 
  left outer join I_MaterialDocumentItem_2 as b on (b.Material = a.Material 
                                                    and b.Batch = a.Batch 
                                                    and b.Plant = a.Plant 
                                                    and b.GoodsMovementType = '501' )
{
  a.Material,
  a.Plant,
  a.MaterialBaseUnit,
  b.Customer,
  sum( a.MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit
}
where
 // MatlDocLatestPostgDate <= dats_add_days ($parameters.P_KeyDate,-1,'UNCHANGED')
  MatlDocLatestPostgDate <= $parameters.P_KeyDate 
group by
  a.Material,
  a.Plant,
  b.Customer,
  a.MaterialBaseUnit
