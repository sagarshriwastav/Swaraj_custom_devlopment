@EndUserText.label: 'Table For Batch Approval'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_TableForBatchApprov
  as select from zmbatch_approva
  association to parent ZI_TableForBatchApprov_S as _TableForBatchAppAll on $projection.SingletonID = _TableForBatchAppAll.SingletonID
{
  key batch as Batch,
  key supplier as Supplier,
  approved as Approved,
  kg as Kg ,
  remark as Remark ,
  description as Description ,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  1 as SingletonID,
  _TableForBatchAppAll
  
}
