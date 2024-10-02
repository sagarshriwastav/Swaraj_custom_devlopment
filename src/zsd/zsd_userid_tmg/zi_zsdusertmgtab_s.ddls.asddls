@EndUserText.label: 'ZSD_USER_TMG_TAB Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZI_ZsdUserTmgTab_S
  as select from I_Language
    left outer join ZSD_USER_TMG_TAB on 0 = 0
  composition [0..*] of ZI_ZsdUserTmgTab as _ZsdUserTmgTab
{
  key 1 as SingletonID,
  _ZsdUserTmgTab,
  max( ZSD_USER_TMG_TAB.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
