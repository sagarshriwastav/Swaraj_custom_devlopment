@EndUserText.label: 'Tabel For Finish Quality Tmg Singleton -'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZC_TabelForFinishQuali_S
  provider contract transactional_query
  as projection on ZI_TabelForFinishQuali_S
{
  key SingletonID,
  LastChangedAtMax,
  TransportRequestID,
  HideTransport,
  _TabelForFinishQuali : redirected to composition child ZC_TabelForFinishQuali
  
}
