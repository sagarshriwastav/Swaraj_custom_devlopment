@AbapCatalog.sqlViewName: 'YPP_APPROVAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'zpp_batch_approval_cds'
define view zpp_batch_approval_cds as select from zmbatch_approva
{
    key batch as Batch,
    key supplier as Supplier,
    approved as Approved,
    kg as Kg,
    remark as Remark,
    description as Description,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
