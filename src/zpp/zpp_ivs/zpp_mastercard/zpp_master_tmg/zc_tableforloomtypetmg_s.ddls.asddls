@EndUserText.label: 'Table For Loom Type  Tmg Singleton - Mai'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_TableForLoomTypeTmg_S
  provider contract transactional_query
  as projection on ZI_TableForLoomTypeTmg_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _TableForLoomTypeTmg : redirected to composition child ZC_TableForLoomTypeTmg
  
}
