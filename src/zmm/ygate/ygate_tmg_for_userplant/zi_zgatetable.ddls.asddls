@EndUserText.label: 'ZGATE TABLE'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZgateTable
  as select from zgate_table
  association to parent ZI_ZgateTable_S as _ZgateTableAll on $projection.SingletonID = _ZgateTableAll.SingletonID
{
  key plant as Plant,
  key user_id as UserId,
  key user_name as UserName,
  key gate_entry_type as GateEntryType,
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
  _ZgateTableAll
  
}
