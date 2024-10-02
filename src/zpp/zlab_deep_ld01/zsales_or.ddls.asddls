@AbapCatalog.sqlViewName: 'ZSALES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'SALES ORDER CDS'
define view ZSALES_OR as select from I_SalesDocument
{
    key SalesDocument
}
