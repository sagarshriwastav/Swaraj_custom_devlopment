@EndUserText.label: 'Maintain ZGATE TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZgateTable_S
  provider contract transactional_query
  as projection on ZI_ZgateTable_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZgateTable : redirected to composition child ZC_ZgateTable
  
}
