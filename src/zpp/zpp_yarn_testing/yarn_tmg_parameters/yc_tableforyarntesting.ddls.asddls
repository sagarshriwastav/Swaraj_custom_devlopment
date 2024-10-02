@EndUserText.label: 'Table For Yarn Testing Parameters Tmg - '
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity YC_TableForYarnTesting
  as projection on YI_TableForYarnTesting
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
  _TableForYarnTestAll : redirected to parent YC_TableForYarnTesting_S
  
}
