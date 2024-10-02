@EndUserText.label: 'Maintain fabric wise table for tmg Singl'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_FabricWiseTableForT_S
  provider contract transactional_query
  as projection on ZI_FabricWiseTableForT_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _FabricWiseTableForT : redirected to composition child ZC_FabricWiseTableForT
  
}
