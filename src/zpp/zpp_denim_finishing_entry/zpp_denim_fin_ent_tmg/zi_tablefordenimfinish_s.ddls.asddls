@EndUserText.label: 'Table For Denim Finishing Entry Tmg Sing'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TableForDenimFinish_S
  as select from I_Language
    left outer join ZPP_DENIM_FIN on 0 = 0
  composition [0..*] of ZI_TableForDenimFinish as _TableForDenimFinish
{
  key 1 as SingletonID,
  _TableForDenimFinish,
  max( ZPP_DENIM_FIN.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
