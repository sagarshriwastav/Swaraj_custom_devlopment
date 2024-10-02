@EndUserText.label: 'NUMBER IN WORDS TABLE Singleton - Mainta'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity YC_NumberInWordsTable_S
  provider contract transactional_query
  as projection on YI_NumberInWordsTable_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _NumberInWordsTable : redirected to composition child YC_NumberInWordsTable
  
}
