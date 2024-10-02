@EndUserText.label: 'Id Wise Auth Singleton - Maintain'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_IdWiseAuth_S
  provider contract transactional_query
  as projection on ZI_IdWiseAuth_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _IdWiseAuth : redirected to composition child ZC_IdWiseAuth
  
}
