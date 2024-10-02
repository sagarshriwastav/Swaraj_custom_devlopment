@AbapCatalog.sqlViewName: 'ZYARNWEFT1200'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Weft Yarn Consumption Report'
define view ZMM_WEFT_YARN_CONSUM_OPEN_1200  with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
  as select from I_MaterialStock as a  
  left outer join  I_Product as c on ( c.Product = a.Material )                                                 
{
 key a.Material,
 key a.Plant, 
 key a.Batch,
     a.MaterialBaseUnit,
     a.Supplier,
     a.SDDocument,
     a.SDDocumentItem,
  sum( a.MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit
  
}
  where  c.IndustryStandardName like 'E'  and ( a.InventorySpecialStockType = 'O' or  a.InventorySpecialStockType = 'F' ) and
//  a.MatlDocLatestPostgDate <= dats_add_days ($parameters.P_KeyDate,-1,'UNCHANGED')
         MatlDocLatestPostgDate <= $parameters.P_KeyDate 
group by
  a.Material,
  a.Plant,
  a.Batch,
  a.Supplier,
  a.SDDocument,
  a.SDDocumentItem,
  a.MaterialBaseUnit  
