@AbapCatalog.sqlViewName: 'YSUMREC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Frc Report Stock Quantity Sum'
define view ZPP_STOCK_QUANTITY_SUM2 as select from ZPP_STOCK_QUANTITY_SUM
{
    key Material,
    key Batch,
    key StorageLocation,
    key Plant,
    StcoKQuantity

} 
  where StcoKQuantity > 0  
