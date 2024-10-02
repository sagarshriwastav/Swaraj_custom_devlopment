@EndUserText.label: 'chemical testing table for tmg'
@AccessControl.authorizationCheck: #CHECK
define view entity YI_ChemicalTestingTabl
  as select from YCHEMICL_PRAMETR
  association to parent YI_ChemicalTestingTabl_S as _ChemicalTestingTAll on $projection.SingletonID = _ChemicalTestingTAll.SingletonID
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
  _ChemicalTestingTAll
  
}
