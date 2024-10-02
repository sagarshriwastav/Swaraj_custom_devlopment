@EndUserText.label: 'Maintain fabric wise table for tmg'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_FabricWiseTableForT
  as projection on ZI_FabricWiseTableForT
{
  key Material,
  Wastegpersantage,
  LocalCreatedBy,
  LocalCreatedAt,
  @Consumption.hidden: true
  LocalLastChangedBy,
  @Consumption.hidden: true
  LocalLastChangedAt,
  LastChangedAt,
  @Consumption.hidden: true
  SingletonID,
  _FabricWiseTableFAll : redirected to parent ZC_FabricWiseTableForT_S
  
}
