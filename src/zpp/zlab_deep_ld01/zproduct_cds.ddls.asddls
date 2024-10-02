@AbapCatalog.sqlViewName: 'ZMATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'material f4'
define view ZPRODUCT_CDS as select from I_Product
{
    key Product
}
