@EndUserText.label: 'Maintain Table For Material Wise Tmg Fi'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_TableForMaterialWis
  as projection on ZI_TableForMaterialWis
{
  key Material,
  key Description,
  @Consumption.hidden: true
  SingletonID,
  _TableForMaterialAll : redirected to parent ZC_TableForMaterialWis_S
  
}
