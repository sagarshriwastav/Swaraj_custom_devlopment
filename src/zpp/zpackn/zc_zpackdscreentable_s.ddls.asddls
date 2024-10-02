@EndUserText.label: 'ZPACKD SCREEN TABLE Singleton - Maintain'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZpackdScreenTable_S
  provider contract transactional_query
  as projection on ZI_ZpackdScreenTable_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZpackdScreenTable : redirected to composition child ZC_ZpackdScreenTable
  
}
