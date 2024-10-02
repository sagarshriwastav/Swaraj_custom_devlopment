@EndUserText.label: 'Maintain ZPM REGION CODE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZpmRegionCode_S
  provider contract transactional_query
  as projection on ZI_ZpmRegionCode_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZpmRegionCode : redirected to composition child ZC_ZpmRegionCode
  
}
