@AbapCatalog.sqlViewName: 'YGATETMG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gate Tmg'
define view ZMM_Zgate_CDS as select from zgate_table
{
  key plant   ,
  user_id    ,
  user_name ,
  gate_entry_type 
}
