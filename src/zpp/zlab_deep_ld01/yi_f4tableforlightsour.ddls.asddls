@EndUserText.label: 'F4 TABLE FOR LIGHT SOURCE'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity YI_F4TableForLightSour
  as select from YF4_LIGHSOURCE
  association to parent YI_F4TableForLightSour_S as _F4TableForLightSAll on $projection.SingletonID = _F4TableForLightSAll.SingletonID
{
  key SRNO as Srno,
  SOURCE_CODE as SourceCode,
  FINISH as Finish,
  @Consumption.hidden: true
  1 as SingletonID,
  _F4TableForLightSAll
  
}
