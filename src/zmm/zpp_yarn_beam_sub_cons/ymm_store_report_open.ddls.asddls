@AbapCatalog.sqlViewName: 'YMM_STORE_OPEN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PP Opening Stock Report'
@ClientHandling.algorithm: #SESSION_VARIABLE
@ObjectModel: {
                usageType: {
                             sizeCategory: #XXL,
                             serviceQuality: #D,
                             dataClass:#TRANSACTIONAL
                           } }
@Metadata.allowExtensions: true
define view YMM_STORE_REPORT_OPEN
  with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
  as select from I_MaterialStock
{
  Material,
  Batch,
  Plant,
  CompanyCode,
  MaterialBaseUnit,
  Supplier,
  sum( MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit
}
where
  MatlDocLatestPostgDate <= $parameters.P_KeyDate and ( InventorySpecialStockType = 'O' or InventorySpecialStockType = 'F' )
group by
  Material,
  Batch,
  Plant,
  CompanyCode,
  Supplier,
  MaterialBaseUnit
