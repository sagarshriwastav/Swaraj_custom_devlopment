@EndUserText.label: 'ZPACKD SCREEN TABLE - Maintain'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZpackdScreenTable
  as projection on ZI_ZpackdScreenTable
{
  key Code,
  Description,
  Farea,
  Ftype,
  Fname,
  Deptno,
  Zdept,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _ZpackdScreenTablAll : redirected to parent ZC_ZpackdScreenTable_S
  
}
