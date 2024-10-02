@EndUserText.label: ' TMG FOR MIGOVALIDATION Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZI_TmgForMigovalidatio_S
  as select from I_Language
    left outer join ZTMG_MIGO_VALIDA on 0 = 0
  composition [0..*] of ZI_TmgForMigovalidatio as _TmgForMigovalidatio
{
  key 1 as SingletonID,
  _TmgForMigovalidatio,
  max( ZTMG_MIGO_VALIDA.LOCAL_LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
