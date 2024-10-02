@EndUserText.label: 'Tabel For Master Card Screen F4'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZWEAVE_S
  as select from ZWEAVE
  association to parent ZI_ZWEAVE_S_S as _TabelForMasterCaAll on $projection.SingletonID = _TabelForMasterCaAll.SingletonID
{
  key WEAVECODE as Weavecode,
  WEAVEDES as Weavedes,
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
  _TabelForMasterCaAll
  
}
