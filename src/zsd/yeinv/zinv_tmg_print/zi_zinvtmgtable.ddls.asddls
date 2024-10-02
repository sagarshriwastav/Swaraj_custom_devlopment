@EndUserText.label: 'ZINV TMG TABLE'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZinvTmgTable
  as select from ZINV_TMG_TABLE
  association to parent ZI_ZinvTmgTable_S as _ZinvTmgTableAll on $projection.SingletonID = _ZinvTmgTableAll.SingletonID
{
  key PLANT as Plant,
  key POLICYNAME as Policyname,
  key POLICYNUMBER as Policynumber,
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
  _ZinvTmgTableAll
  
}
