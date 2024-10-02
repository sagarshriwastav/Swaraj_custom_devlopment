@EndUserText.label: 'Tabel For Finish Quality Tmg - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_TabelForFinishQuali
  as projection on ZI_TabelForFinishQuali
{
  key Parentsort,
  key Plant,
  Finwd,
  Unit,
  Weight,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _TabelForFinishQuAll : redirected to parent ZC_TabelForFinishQuali_S
  
}
