@EndUserText.label: 'Table For Batch Approval Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TableForBatchApprov_S
  as select from I_Language
    left outer join ZMBATCH_APPROVA on 0 = 0
  composition [0..*] of ZI_TableForBatchApprov as _TableForBatchApprov
{
  key 1 as SingletonID,
  _TableForBatchApprov,
  max( ZMBATCH_APPROVA.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
