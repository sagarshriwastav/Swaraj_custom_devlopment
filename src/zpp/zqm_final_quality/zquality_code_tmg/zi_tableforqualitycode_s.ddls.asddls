@EndUserText.label: 'Table For Quality Code  Tmg Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TableForQualityCode_S
  as select from I_Language
    left outer join ZQM_CODE on 0 = 0
  composition [0..*] of ZI_TableForQualityCode as _TableForQualityCode
{
  key 1 as SingletonID,
  _TableForQualityCode,
  max( ZQM_CODE.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
