@EndUserText.label: 'Quality Code'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_QualityCode
  as select from zqcd
  association to parent ZI_QualityCode_S as _QualityCodeAll on $projection.SingletonID = _QualityCodeAll.SingletonID
{
  key cbcode as Cbcode,
  cgcode as Cgcode,
  rescnt as Rescnt,
  maktx as Maktx,
  waste as Waste,
  erdat as Erdat,
  ernam as Ernam,
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
  _QualityCodeAll
  
}
