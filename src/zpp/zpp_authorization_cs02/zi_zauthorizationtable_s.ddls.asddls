@EndUserText.label: 'ZAUTHORIZATION TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZauthorizationTable_S
  as select from I_Language
    left outer join ZAUTH_TABLE on 0 = 0
  composition [0..*] of ZI_ZauthorizationTable as _ZauthorizationTable
{
  key 1 as SingletonID,
  _ZauthorizationTable,
  max( ZAUTH_TABLE.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
