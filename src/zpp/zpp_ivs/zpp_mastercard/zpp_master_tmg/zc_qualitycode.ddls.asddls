@EndUserText.label: 'Quality Code - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_QualityCode
  as projection on ZI_QualityCode
{
  key Cbcode,
  Cgcode,
  Rescnt,
  Maktx,
  Waste,
  Erdat,
  Ernam,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _QualityCodeAll : redirected to parent ZC_QualityCode_S
  
}
