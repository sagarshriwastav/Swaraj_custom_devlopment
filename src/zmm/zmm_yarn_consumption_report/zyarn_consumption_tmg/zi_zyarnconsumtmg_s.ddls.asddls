@EndUserText.label: 'ZYARN CONSUM TMG Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZyarnConsumTmg_S
  as select from I_Language
    left outer join ZYARN_CONSUM_TMG on 0 = 0
  composition [0..*] of ZI_ZyarnConsumTmg as _ZyarnConsumTmg
{
  key 1 as SingletonID,
  _ZyarnConsumTmg,
  max( ZYARN_CONSUM_TMG.LASTCHANGEDAT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
