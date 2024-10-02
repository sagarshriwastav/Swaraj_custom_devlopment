@EndUserText.label: 'fabric wise table for tmg Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_FabricWiseTableForT_S
  as select from I_Language
    left outer join ZMM_FABRICWISE on 0 = 0
  composition [0..*] of ZI_FabricWiseTableForT as _FabricWiseTableForT
{
  key 1 as SingletonID,
  _FabricWiseTableForT,
  max( ZMM_FABRICWISE.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
