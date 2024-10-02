@AbapCatalog.sqlViewName: 'YIDAUTH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Id Wise Authorisation'
define view zpp_id_wise_autho as select from zpp_id_wise_aut
{
    key plant,
    key userid,
    key zprogram,
    key department
   
}
