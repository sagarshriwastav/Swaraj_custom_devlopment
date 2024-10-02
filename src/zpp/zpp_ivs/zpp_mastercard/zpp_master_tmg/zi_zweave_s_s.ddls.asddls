@EndUserText.label: 'Tabel For Master Card Screen F4 Singleto'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZWEAVE_S_S
  as select from I_Language
    left outer join ZWEAVE on 0 = 0
  composition [0..*] of ZI_ZWEAVE_S as _ZWEAVE_S
{
  key 1 as SingletonID,
  _ZWEAVE_S,
  max( ZWEAVE.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
