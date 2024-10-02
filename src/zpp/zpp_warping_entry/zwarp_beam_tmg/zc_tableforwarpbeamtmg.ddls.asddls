@EndUserText.label: 'Table For Warp Beam Tmg - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_TableForWarpBeamTmg
  as projection on ZI_TableForWarpBeamTmg
{
  key Plant,
  key Beamno,
  Beamwt,
  Remark,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _TableForWarpBeamAll : redirected to parent ZC_TableForWarpBeamTmg_S
  
}
