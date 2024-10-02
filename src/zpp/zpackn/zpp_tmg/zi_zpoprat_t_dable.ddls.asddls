@EndUserText.label: 'ZPACKD SCREEN TABLE'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZpOPRAT_T_Dable
  as select from zdenim_oprat_tab
  association to parent ZI_ZpackdScreenOP_1 as _ZpackdScreenTab121 on $projection.SingletonID = _ZpackdScreenTab121.SingletonID
{
  key bukrs as Bukrs,
  key plant as Plant,
  key empcode as Empcode,
  empname as Empname,
  deptname as Deptname,
  cancel as Cancel,
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
  _ZpackdScreenTab121
  
}
