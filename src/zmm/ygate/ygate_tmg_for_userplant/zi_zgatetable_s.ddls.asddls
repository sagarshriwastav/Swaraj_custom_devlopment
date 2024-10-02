@EndUserText.label: 'ZGATE TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZgateTable_S
  as select from I_Language
    left outer join ZGATE_TABLE on 0 = 0
  composition [0..*] of ZI_ZgateTable as _ZgateTable
{
  key 1 as SingletonID,
  _ZgateTable,
  max( ZGATE_TABLE.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
