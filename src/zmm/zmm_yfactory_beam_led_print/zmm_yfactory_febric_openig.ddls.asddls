@AbapCatalog.sqlViewName: 'YARNFEBRI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds View For Yarn Febric Opening'
define view ZMM_YFACTORY_FEBRIC_OPENIG with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
  as select from I_MaterialStock as a 
  left outer join I_MaterialDocumentItem_2 as C on ( C.Material = a.Material and C.Batch = a.Batch )
  left outer join I_SalesDocument as b on ( b.SalesDocument = a.SDDocument  )
{
 key a.Plant,
 key a.Material,
 key a.Batch, 
    a.SDDocument,
  b.SoldToParty,
  sum( a.MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit
}
where a.InventorySpecialStockType = 'E' and ( a.Material like 'FGJ%' or a.Material like 'FGJL%' ) // and C.GoodsMovementType = '561' 
// and C.GoodsMovementIsCancelled = '' 
and MatlDocLatestPostgDate <= dats_add_days ($parameters.P_KeyDate,-1,'UNCHANGED')
 // MatlDocLatestPostgDate <= $parameters.P_KeyDate 
group by
   
  a.Material,
  a.Batch,
  a.Plant,
  b.SoldToParty,
  a.SDDocument
