@EndUserText.label: 'ZPACKD SCREEN TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZpackdScreenTable_S
  as select from I_Language
    left outer join ZPACKFAULT on 0 = 0
  composition [0..*] of ZI_ZpackdScreenTable as _ZpackdScreenTable
{
  key 1 as SingletonID,
  _ZpackdScreenTable,
  max( ZPACKFAULT.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
