@AbapCatalog.sqlViewName: 'YGOODS2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Goods Transaction Report'
define view ZGOODS_TRANSACTION_CDS1 as select from ZGOODS_TRANSACTION_CDS
{
   key Material,
   key Plant
}  
  where Material <> ''
   group by 
   Material,
   Plant
