@AbapCatalog.sqlViewName: 'YTMGF'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FINISH F4'
define view ZFINISHCDS as
 select from ylightsouef4_tmg as A
{
    A.finish
}
