@EndUserText.label: 'ZPM REGION CODE'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZpmRegionCode
  as select from zpm_region_code
  association to parent ZI_ZpmRegionCode_S as _ZpmRegionCodeAll on $projection.SingletonID = _ZpmRegionCodeAll.SingletonID
{
  key code as Code,
  description as Description,
  department as Department,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  1 as SingletonID,
  _ZpmRegionCodeAll
  
}
