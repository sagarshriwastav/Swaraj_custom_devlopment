@EndUserText.label: 'Table For Warp Beam Tmg'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_TableForWarpBeamTmg
  as select from ZWARP_BEAM_TMG
  association to parent ZI_TableForWarpBeamTmg_S as _TableForWarpBeamAll on $projection.SingletonID = _TableForWarpBeamAll.SingletonID
{
  key PLANT as Plant,
  key BEAMNO as Beamno,
  BEAMWT as Beamwt,
  REMARK as Remark,
  @Semantics.user.createdBy: true
  LOCAL_CREATED_BY as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LOCAL_CREATED_AT as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  1 as SingletonID,
  _TableForWarpBeamAll
  
}
