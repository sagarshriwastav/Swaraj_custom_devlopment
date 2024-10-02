@EndUserText.label: 'Maintain ZBANK TMG TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZbankTmgTable_S
  provider contract transactional_query
  as projection on ZI_ZbankTmgTable_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZbankTmgTable : redirected to composition child ZC_ZbankTmgTable
  
}
