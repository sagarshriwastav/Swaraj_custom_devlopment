@AbapCatalog.sqlViewName: 'YTMG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'LIGHT SOURCE F4'
define view ZSOURCECDS as
 select from  ylightsouef4_tmg as A
{
    A.source_code
}
