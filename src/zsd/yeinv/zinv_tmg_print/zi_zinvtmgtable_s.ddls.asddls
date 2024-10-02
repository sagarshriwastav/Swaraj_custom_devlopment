@EndUserText.label: 'ZINV TMG TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZinvTmgTable_S
  as select from I_Language
    left outer join ZINV_TMG_TABLE on 0 = 0
  composition [0..*] of ZI_ZinvTmgTable as _ZinvTmgTable
{
  key 1 as SingletonID,
  _ZinvTmgTable,
  max( ZINV_TMG_TABLE.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
