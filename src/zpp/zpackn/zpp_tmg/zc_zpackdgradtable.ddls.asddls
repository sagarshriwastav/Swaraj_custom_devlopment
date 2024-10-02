@EndUserText.label: 'ZPACKD SCREEN TABLE - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define  view entity ZC_ZpackdGRADTable
  as projection on ZI_ZGRADScreenTable
{
  key Werks,
  key Prctr,
  key Grade,
  Zdesc,
  Zsnro,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ZpackdScreeGRAD : redirected to parent ZC_ZpackdGRAD_S
  
}
