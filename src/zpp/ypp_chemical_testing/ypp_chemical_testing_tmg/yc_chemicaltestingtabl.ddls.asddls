@EndUserText.label: 'Maintain chemical testing table for tmg'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity YC_ChemicalTestingTabl
  as projection on YI_ChemicalTestingTabl
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
  _ChemicalTestingTAll : redirected to parent YC_ChemicalTestingTabl_S
  
}
