@AbapCatalog.sqlViewName: 'YPM_REASON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPM_REASON_CODE'
define view ZPM_REASON_CODE as select from zpm_region_code
{
    key code as Code,
    description as Description,
    department as Department,
    created_by as CreatedBy,
    created_at as CreatedAt,
    last_changed_by as LastChangedBy,
    last_changed_at as LastChangedAt,
    local_last_changed_at as LocalLastChangedAt
}
