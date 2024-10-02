@AbapCatalog.sqlViewName: 'YPPROUTE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Finish Entry'
define view ZPP_DENIM_ROUTE as select from zpp_denim_fin
{
    key plant as Plant,
    route as Route
    
    
}  group by 
    plant,
    route
