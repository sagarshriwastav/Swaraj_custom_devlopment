@EndUserText.label: 'ZPACKD SCREEN TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZpackdScreenGRAD_S
  as select from I_Language
    left outer join ZWEAV_GRAD_TAB on 0 = 0
  composition [0..*] of ZI_ZGRADScreenTable as _ZpackdGRADTable
{
  key 1 as SingletonID,
  _ZpackdGRADTable,
  max( ZWEAV_GRAD_TAB.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
