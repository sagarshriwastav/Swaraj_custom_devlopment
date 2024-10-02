@AbapCatalog.sqlViewName: 'YTRANSFERRR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Plant F4'
define view ZPP_TRANSFER_POSTING_PLANT_F4 as select from ZPP_TRANSFER_POSTING_CDS
{
    key Plant
    
} 
  group by 
     Plant
