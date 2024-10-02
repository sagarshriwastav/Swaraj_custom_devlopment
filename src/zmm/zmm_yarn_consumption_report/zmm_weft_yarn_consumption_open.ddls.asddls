@AbapCatalog.sqlViewName: 'ZYARNWEFT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Weft Yarn Consumption Report'
define view ZMM_WEFT_YARN_CONSUMPTION_OPEN  with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
  as select from I_MaterialStock as a  
  left outer join I_MaterialDocumentItem_2 as b on (b.Material = a.Material 
                                                    and b.Batch = a.Batch 
                                                    and b.Plant = a.Plant 
                                                    and b.GoodsMovementType = '501' )
  left outer join  I_Product as c on ( c.Product = a.Material )                                                 
{
 key a.Material,
 key a.Plant,
 key b.Customer, 
     a.MaterialBaseUnit,
  sum( a.MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit
}
  where  c.IndustryStandardName like 'E'  and
//  a.MatlDocLatestPostgDate <= dats_add_days ($parameters.P_KeyDate,-1,'UNCHANGED')
  MatlDocLatestPostgDate <= $parameters.P_KeyDate 
group by
  a.Material,
  a.Plant,
  b.Customer,
  a.MaterialBaseUnit  
