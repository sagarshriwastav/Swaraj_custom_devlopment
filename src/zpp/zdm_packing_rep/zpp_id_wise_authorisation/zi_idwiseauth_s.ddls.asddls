@EndUserText.label: 'Id Wise Auth Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_IdWiseAuth_S
  as select from I_Language
    left outer join ZPP_ID_WISE_AUT on 0 = 0
  composition [0..*] of ZI_IdWiseAuth as _IdWiseAuth
{
  key 1 as SingletonID,
  _IdWiseAuth,
  max( ZPP_ID_WISE_AUT.LOCAL_LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
