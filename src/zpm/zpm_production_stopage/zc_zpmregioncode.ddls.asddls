@EndUserText.label: 'Maintain ZPM REGION CODE'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZpmRegionCode
  as projection on ZI_ZpmRegionCode
{
  key Code,
  Description,
  Department,
  CreatedBy,
  CreatedAt,
  @Consumption.hidden: true
  LastChangedBy,
  @Consumption.hidden: true
  LastChangedAt,
  LocalLastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ZpmRegionCodeAll : redirected to parent ZC_ZpmRegionCode_S
  
}
