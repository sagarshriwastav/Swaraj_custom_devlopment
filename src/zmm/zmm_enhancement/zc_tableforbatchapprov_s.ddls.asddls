@EndUserText.label: 'Maintain Table For Batch Approval Single'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_TableForBatchApprov_S
  provider contract transactional_query
  as projection on ZI_TableForBatchApprov_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _TableForBatchApprov : redirected to composition child ZC_TableForBatchApprov
  
}
