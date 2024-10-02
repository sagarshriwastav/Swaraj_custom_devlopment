@EndUserText.label: 'Table For Quality Code  Tmg'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_TableForQualityCode
  as select from ZQM_CODE
  association to parent ZI_TableForQualityCode_S as _TableForQualityCAll on $projection.SingletonID = _TableForQualityCAll.SingletonID
{
  key SERIALNO as Serialno,
  ZPARAMETER as Zparameter,
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
  _TableForQualityCAll
  
}
