@EndUserText.label: 'Quality Code Singleton - Maintain'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_QualityCode_S
  provider contract transactional_query
  as projection on ZI_QualityCode_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _QualityCode : redirected to composition child ZC_QualityCode
  
}
