@EndUserText.label: 'Table For Dyeing Shade Tmg Singleton - M'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_DyeingShade_S
  provider contract transactional_query
  as projection on ZI_DyeingShade_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _DyeingShade : redirected to composition child ZC_DyeingShade
  
}
