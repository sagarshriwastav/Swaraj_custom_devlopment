@EndUserText.label: 'Table For Quality Code  Tmg Singleton - '
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_TableForQualityCode_S
  provider contract transactional_query
  as projection on ZI_TableForQualityCode_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _TableForQualityCode : redirected to composition child ZC_TableForQualityCode
  
}
