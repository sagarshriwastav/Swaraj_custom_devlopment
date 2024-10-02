@EndUserText.label: 'fabric wise table for tmg'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_FabricWiseTableForT
  as select from ZMM_FABRICWISE
  association to parent ZI_FabricWiseTableForT_S as _FabricWiseTableFAll on $projection.SingletonID = _FabricWiseTableFAll.SingletonID
{
  key MATERIAL as Material,
  WASTEGPERSANTAGE as Wastegpersantage,
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
  _FabricWiseTableFAll
  
}
