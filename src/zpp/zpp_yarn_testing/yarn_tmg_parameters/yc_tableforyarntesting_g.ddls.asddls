@EndUserText.label: 'Table For Yarn Testing Parameters Tmg Si'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity YC_TableForYarnTesting_G
  provider contract transactional_query
  as projection on YI_TableForYarnTesting_G
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _TableForYarnTesting : redirected to composition child YC_TableForYarnTestingG
  
}
