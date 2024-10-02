@EndUserText.label: 'SERACH HELP FOR LIGHT SOURCE'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity YI_SerachHelpForLightS
  as select from YLIGHTSOUEF4_TMG
  association to parent YI_SerachHelpForLightS_S as _SerachHelpForLigAll on $projection.SingletonID = _SerachHelpForLigAll.SingletonID
{
  key SRNO as Srno,
  SOURCE_CODE as SourceCode,
  FINISH as Finish,
  @Semantics.user.createdBy: true
  CREATED_BY as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  CREATED_AT as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  @Consumption.hidden: true
  LAST_CHANGED_BY as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  @Consumption.hidden: true
  LAST_CHANGED_AT as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Consumption.hidden: true
  1 as SingletonID,
  _SerachHelpForLigAll
  
}
