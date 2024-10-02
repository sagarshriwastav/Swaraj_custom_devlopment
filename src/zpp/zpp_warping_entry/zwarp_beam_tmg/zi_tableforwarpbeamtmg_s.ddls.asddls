@EndUserText.label: 'Table For Warp Beam Tmg Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TableForWarpBeamTmg_S
  as select from I_Language
    left outer join ZWARP_BEAM_TMG on 0 = 0
  composition [0..*] of ZI_TableForWarpBeamTmg as _TableForWarpBeamTmg
{
  key 1 as SingletonID,
  _TableForWarpBeamTmg,
  max( ZWARP_BEAM_TMG.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
