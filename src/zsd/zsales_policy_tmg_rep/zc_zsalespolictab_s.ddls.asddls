@EndUserText.label: 'Maintain ZSALES POLIC TAB Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_ZsalesPolicTab_S
  provider contract transactional_query
  as projection on ZI_ZsalesPolicTab_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ZsalesPolicTab : redirected to composition child ZC_ZsalesPolicTab
  
}    
