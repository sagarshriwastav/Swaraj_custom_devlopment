@EndUserText.label: 'Table For Denim Finishing Entry Tmg Sing'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_TableForDenimFinish_S
  provider contract transactional_query
  as projection on ZI_TableForDenimFinish_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _TableForDenimFinish : redirected to composition child ZC_TableForDenimFinish
  
}
