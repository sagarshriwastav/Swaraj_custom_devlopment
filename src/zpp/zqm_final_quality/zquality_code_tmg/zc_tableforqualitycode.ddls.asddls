@EndUserText.label: 'Table For Quality Code  Tmg - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_TableForQualityCode
  as projection on ZI_TableForQualityCode
{
  key Serialno,
  Zparameter,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _TableForQualityCAll : redirected to parent ZC_TableForQualityCode_S
  
}
