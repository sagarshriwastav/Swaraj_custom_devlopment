@EndUserText.label: 'ZPACKD SCREEN TABLE Singleton - Maintain'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZpackdScreenOP_1
  provider contract transactional_query
  as projection on ZI_ZpackdScreenOP_1
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZpackScreenOPRAT_T_ : redirected to composition child ZC_ZpackdScreOPRAT_T_D
  
}
