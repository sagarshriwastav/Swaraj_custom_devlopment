@EndUserText.label: 'Table For Yarn Testing Parameters Tmg Si'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity YI_TableForYarnTesting_S
  as select from I_Language
    left outer join YTEST_PARAMETETR on 0 = 0
  composition [0..*] of YI_TableForYarnTesting as _TableForYarnTesting
{
  key 1 as SingletonID,
  _TableForYarnTesting,
  max( YTEST_PARAMETETR.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
