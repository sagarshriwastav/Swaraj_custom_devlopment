@EndUserText.label: 'ZPACKD SCREEN TABLE'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZpackdScreenTable
  as select from ZPACKFAULT
  association to parent ZI_ZpackdScreenTable_S as _ZpackdScreenTablAll on $projection.SingletonID = _ZpackdScreenTablAll.SingletonID
{
  key CODE as Code,
  DESCRIPTION as Description,
  FAREA as Farea,
  FTYPE as Ftype,
  FNAME as Fname,
  DEPTNO as Deptno,
  ZDEPT as Zdept,
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
  _ZpackdScreenTablAll
  
}
