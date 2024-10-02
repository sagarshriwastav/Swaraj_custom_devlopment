@EndUserText.label: 'Tabel For Finish Quality Tmg'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_TabelForFinishQuali
  as select from ZDM_SORTMASTER
  association to parent ZI_TabelForFinishQuali_S as _TabelForFinishQuAll on $projection.SingletonID = _TabelForFinishQuAll.SingletonID
{
  key PARENTSORT as Parentsort,
  key PLANT as Plant,
  FINWD as Finwd,
  UNIT as Unit,
  @Semantics.quantity.unitOfMeasure: 'Unit'
  WEIGHT as Weight,
  @Semantics.user.createdBy: true
  LOCAL_CREATED_BY as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LOCAL_CREATED_AT as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  1 as SingletonID,
  _TabelForFinishQuAll
  
}
