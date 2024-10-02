@EndUserText.label: 'ZPM REGION CODE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZpmRegionCode_S
  as select from I_Language
    left outer join ZPM_REGION_CODE on 0 = 0
  composition [0..*] of ZI_ZpmRegionCode as _ZpmRegionCode
{
  key 1 as SingletonID,
  _ZpmRegionCode,
  max( ZPM_REGION_CODE.LOCAL_LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
