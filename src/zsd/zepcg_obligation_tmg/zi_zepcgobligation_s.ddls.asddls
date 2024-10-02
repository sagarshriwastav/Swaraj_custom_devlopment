@EndUserText.label: 'ZEPCG OBLIGATION Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZepcgObligation_S
  as select from I_Language
    left outer join ZEPCG_OBLIGATION on 0 = 0
  composition [0..*] of ZI_ZepcgObligation as _ZepcgObligation
{
  key 1 as SingletonID,
  _ZepcgObligation,
  max( ZEPCG_OBLIGATION.LASTCHANGEDAT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
