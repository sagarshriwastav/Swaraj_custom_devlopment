@EndUserText.label: 'ZIRN CREDENTIALS Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZirnCredentials_S
  as select from I_Language
    left outer join ZIRN_CREDENTIALS on 0 = 0
  composition [0..*] of ZI_ZirnCredentials as _ZirnCredentials
{
  key 1 as SingletonID,
  _ZirnCredentials,
  max( ZIRN_CREDENTIALS.LOCAL_LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
