@EndUserText.label: 'Table For Loom Type  Tmg'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_TableForLoomTypeTmg
  as select from ZLOOM_TYPE
  association to parent ZI_TableForLoomTypeTmg_S as _TableForLoomTypeAll on $projection.SingletonID = _TableForLoomTypeAll.SingletonID
{
  key SERIALNO as Serialno,
  LOOMTYPE as Loomtype,
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
  _TableForLoomTypeAll
  
}
