@EndUserText.label: 'Maintain Table For Material Wise Tmg Fi '
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_TableForMaterialWis_S
  provider contract transactional_query
  as projection on ZI_TableForMaterialWis_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _TableForMaterialWis : redirected to composition child ZC_TableForMaterialWis
  
}
