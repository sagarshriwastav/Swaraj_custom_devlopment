@EndUserText.label: 'Maintain ZYARN CONSUM TMG Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZyarnConsumTmg_S
  provider contract transactional_query
  as projection on ZI_ZyarnConsumTmg_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZyarnConsumTmg : redirected to composition child ZC_ZyarnConsumTmg
  
}
