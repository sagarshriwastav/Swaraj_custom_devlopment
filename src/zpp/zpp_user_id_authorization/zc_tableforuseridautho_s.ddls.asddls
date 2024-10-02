@EndUserText.label: 'Maintain Table For User Id Authorization'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_TableForUserIdAutho_S
  provider contract transactional_query
  as projection on ZI_TableForUserIdAutho_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _TableForUserIdAutho : redirected to composition child ZC_TableForUserIdAutho
  
}
