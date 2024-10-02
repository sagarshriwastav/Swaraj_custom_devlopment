@EndUserText.label: 'Table For Denim Finishing Entry Tmg'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_TableForDenimFinish
  as select from ZPP_DENIM_FIN
  association to parent ZI_TableForDenimFinish_S as _TableForDenimFinAll on $projection.SingletonID = _TableForDenimFinAll.SingletonID
{
  key PLANT as Plant,
  ROUTE as Route,
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
  _TableForDenimFinAll
  
}
