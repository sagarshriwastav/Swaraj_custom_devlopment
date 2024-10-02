@AbapCatalog.sqlViewName: 'Y_AUTH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_AUTH_CS02_CDS'
define view ZPP_AUTH_CS02_CDS as select from zauth_table
{
    key username as Username,
    sno as Sno,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
