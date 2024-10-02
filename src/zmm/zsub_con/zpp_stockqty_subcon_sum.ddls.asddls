@AbapCatalog.sqlViewName: 'YSUBCONSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Subcon Supplier F4'
define view ZPP_STOCKQTY_SUBCON_SUM as select from ZPP_STOCKQTY_SUBCON
{
    key Material,
    key Plant,
    key Batch,
    MaterialBaseUnit,
    StorageLocation,
    StockQty
}   where  StockQty > 0
