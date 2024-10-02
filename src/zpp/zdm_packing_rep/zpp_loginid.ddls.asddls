@AbapCatalog.sqlViewName: 'YLOGINID'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Login Id'
define view ZPP_LOGINID as select from zpp_user_table
{
    key username as Username,
    key password as Password,
    mattpye as Mattpye
}
