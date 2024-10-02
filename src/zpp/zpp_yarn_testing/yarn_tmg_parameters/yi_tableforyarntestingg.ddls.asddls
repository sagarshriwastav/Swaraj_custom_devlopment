@EndUserText.label: 'Table For Yarn Testing Parameters Tmg'
@AccessControl.authorizationCheck: #CHECK
define view entity YI_TableForYarnTestingG
  as select from YTEST_PARAMETERS
  association to parent YI_TableForYarnTesting_G as _TableForYarnTestAll on $projection.SingletonID = _TableForYarnTestAll.SingletonID
{
  key PLANT as Plant,
  key SRNO as Srno,
  key PROGARAM as Progaram,
  key PROGARAMNO as Progaramno,
  key PROGARAMNAME as Progaramname,
  key PARAMETERS as Parameters,
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
  _TableForYarnTestAll
  
}
