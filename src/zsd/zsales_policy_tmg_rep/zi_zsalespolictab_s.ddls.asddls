@EndUserText.label: 'ZSALES POLIC TAB Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZsalesPolicTab_S
  as select from I_Language
    left outer join ZSALES_POLIC_TAB on 0 = 0
  composition [0..*] of ZI_ZsalesPolicTab as _ZsalesPolicTab
{
  key 1 as SingletonID,
  _ZsalesPolicTab,
  max( ZSALES_POLIC_TAB.LASTCHANGEDAT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
    
