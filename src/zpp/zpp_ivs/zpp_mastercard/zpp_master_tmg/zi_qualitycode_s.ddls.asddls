@EndUserText.label: 'Quality Code Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_QualityCode_S
  as select from I_Language
    left outer join ZQCD on 0 = 0
  composition [0..*] of ZI_QualityCode as _QualityCode
{
  key 1 as SingletonID,
  _QualityCode,
  max( ZQCD.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
