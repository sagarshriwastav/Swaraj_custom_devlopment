@AbapCatalog.sqlViewName: 'YDEL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Print'
define view YGATECDS_PRINT as select from YGATE_ITEMCDS
{
    key Gateno,
    key Delievery
}  
  group by 
  Gateno,
  Delievery
  
