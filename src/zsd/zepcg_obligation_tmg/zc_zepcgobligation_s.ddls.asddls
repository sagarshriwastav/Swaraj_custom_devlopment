@EndUserText.label: 'Maintain ZEPCG OBLIGATION Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZepcgObligation_S
  provider contract transactional_query
  as projection on ZI_ZepcgObligation_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZepcgObligation : redirected to composition child ZC_ZepcgObligation
  
}
