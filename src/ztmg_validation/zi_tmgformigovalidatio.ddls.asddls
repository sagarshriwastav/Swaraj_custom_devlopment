@EndUserText.label: ' TMG FOR MIGOVALIDATION'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_TmgForMigovalidatio
  as select from ztmg_migo_valida
  association to parent ZI_TmgForMigovalidatio_S as _TmgForMigovalidaAll on $projection.SingletonID = _TmgForMigovalidaAll.SingletonID
{
  key sr_no as SrNo,
  username as Username,
  user_id as userid,
  remark as remark,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  @Consumption.hidden: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  @Consumption.hidden: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Consumption.hidden: true
  1 as SingletonID,
  _TmgForMigovalidaAll
  
}
