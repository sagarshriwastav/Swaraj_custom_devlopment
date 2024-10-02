@EndUserText.label: 'Table For Warp Beam Tmg Singleton - Main'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_TableForWarpBeamTmg_S
  provider contract transactional_query
  as projection on ZI_TableForWarpBeamTmg_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _TableForWarpBeamTmg : redirected to composition child ZC_TableForWarpBeamTmg
  
}
