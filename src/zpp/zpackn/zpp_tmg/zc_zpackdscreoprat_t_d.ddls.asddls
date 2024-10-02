@EndUserText.label: 'ZPACKD SCREEN TABLE - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZpackdScreOPRAT_T_D
  as projection on ZI_ZpOPRAT_T_Dable
{
  key Bukrs,
  key Plant,
 key Empcode,
  Empname,
  Deptname,
  Cancel,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ZpackdScreenTab121 : redirected to parent ZC_ZpackdScreenOP_1
  
}
