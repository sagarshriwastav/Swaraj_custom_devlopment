@EndUserText.label: 'tmg for lightsource f4'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_TmgForLightsourceF4
  as select from zlightsource_tmg
  association to parent ZI_TmgForLightsourceF4_S as _TmgForLightsourcAll on $projection.SingletonID = _TmgForLightsourcAll.SingletonID
{
  key sno as SNO,
     cl as CL,
     fooo2 as FOOO2,
     finish as FINISH,
  
  @Consumption.hidden: true
  1 as SingletonID,
  _TmgForLightsourcAll
  
}
