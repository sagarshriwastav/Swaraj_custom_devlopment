@AbapCatalog.sqlViewName: 'YSUMSTOCK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Pending Report Stock'
define view ZSD_PENDING_ORDER_STOCK_1 as select from ZSD_PENDING_ORDER_STOCK
{
   
    key SDDocument,
    key SDDocumentItem,
    key Material,
    MaterialBaseUnit,
    OrStock
}   
    where OrStock > 0
