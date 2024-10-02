@EndUserText.label: 'chemical testing table for tmg Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity YI_ChemicalTestingTabl_S
  as select from I_Language
    left outer join YCHEMICL_PRAMETR on 0 = 0
  composition [0..*] of YI_ChemicalTestingTabl as _ChemicalTestingTabl
{
  key 1 as SingletonID,
  _ChemicalTestingTabl,
  max( YCHEMICL_PRAMETR.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
