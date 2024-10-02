@EndUserText.label: 'Maintain ZINV TMG TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZinvTmgTable_S
  provider contract transactional_query
  as projection on ZI_ZinvTmgTable_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZinvTmgTable : redirected to composition child ZC_ZinvTmgTable
  
}
