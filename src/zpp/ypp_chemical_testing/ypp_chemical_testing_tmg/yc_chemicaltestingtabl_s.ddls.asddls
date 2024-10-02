@EndUserText.label: 'Maintain chemical testing table for tmg '
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity YC_ChemicalTestingTabl_S
  provider contract transactional_query
  as projection on YI_ChemicalTestingTabl_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _ChemicalTestingTabl : redirected to composition child YC_ChemicalTestingTabl
  
}
