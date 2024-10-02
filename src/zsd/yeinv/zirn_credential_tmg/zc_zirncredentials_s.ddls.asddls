@EndUserText.label: 'ZIRN CREDENTIALS Singleton - Maintain'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZirnCredentials_S
  provider contract transactional_query
  as projection on ZI_ZirnCredentials_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZirnCredentials : redirected to composition child ZC_ZirnCredentials
  
}
