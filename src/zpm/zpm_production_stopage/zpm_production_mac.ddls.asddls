@AbapCatalog.sqlViewName: 'ZPRODUCTION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPM_PRODUCTION_MAC'
define view ZPM_PRODUCTION_MAC as select from I_TechnicalObject
{
    key Equipment
}
where Equipment is not initial
