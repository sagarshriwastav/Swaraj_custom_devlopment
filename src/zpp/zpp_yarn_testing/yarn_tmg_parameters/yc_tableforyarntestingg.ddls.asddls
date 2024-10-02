@EndUserText.label: 'Table For Yarn Testing Parameters Tmg - '
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity YC_TableForYarnTestingG
  as projection on YI_TableForYarnTestingG
{
  key Plant,
  key Srno,
  key Progaram,
  key Progaramno,
  key Progaramname,
  key Parameters,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _TableForYarnTestAll : redirected to parent YC_TableForYarnTesting_G
  
}
