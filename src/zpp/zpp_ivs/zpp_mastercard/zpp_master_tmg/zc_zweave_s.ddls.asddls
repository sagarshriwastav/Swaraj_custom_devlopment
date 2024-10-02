@EndUserText.label: 'Tabel For Master Card Screen F4 - Mainta'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZWEAVE_S
  as projection on ZI_ZWEAVE_S
{
  key Weavecode,
  Weavedes,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _TabelForMasterCaAll : redirected to parent ZC_ZWEAVE_S_S
  
}
