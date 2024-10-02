@EndUserText.label: 'Table For Material Wise Tmg Fi'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_TableForMaterialWis
  as select from ZFI_MATERIAL_TMG
  association to parent ZI_TableForMaterialWis_S as _TableForMaterialAll on $projection.SingletonID = _TableForMaterialAll.SingletonID
{
  key MATERIAL as Material,
  key DESCRIPTION as Description,
  1 as SingletonID,
  _TableForMaterialAll
  
}
