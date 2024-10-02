@EndUserText.label: 'Maintain ZAUTHORIZATION TABLE'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZauthorizationTable
  as projection on ZI_ZauthorizationTable
{
  key Username,
  Sno,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ZauthorizationTaAll : redirected to parent ZC_ZauthorizationTable_S
  
}
