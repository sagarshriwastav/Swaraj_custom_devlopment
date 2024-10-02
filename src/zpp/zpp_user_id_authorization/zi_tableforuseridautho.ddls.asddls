@EndUserText.label: 'Table For User Id Authorization'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_TableForUserIdAutho
  as select from zpp_user_table
  association to parent ZI_TableForUserIdAutho_S as _TableForUserIdAuAll on $projection.SingletonID = _TableForUserIdAuAll.SingletonID
{
  key username as Username,
  key password as Password,
  mattpye,
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
  _TableForUserIdAuAll
  
}
