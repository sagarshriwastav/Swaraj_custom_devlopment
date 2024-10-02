@EndUserText.label: 'Maintain ZAUTHORIZATION TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZauthorizationTable_S
  provider contract transactional_query
  as projection on ZI_ZauthorizationTable_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZauthorizationTable : redirected to composition child ZC_ZauthorizationTable
  
}
