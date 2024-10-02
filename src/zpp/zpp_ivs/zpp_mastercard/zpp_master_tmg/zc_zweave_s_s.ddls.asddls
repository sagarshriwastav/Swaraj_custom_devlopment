@EndUserText.label: 'Tabel For Master Card Screen F4 Singleto'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZWEAVE_S_S
  provider contract transactional_query
  as projection on ZI_ZWEAVE_S_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZWEAVE_S : redirected to composition child ZC_ZWEAVE_S
  
}
