@EndUserText.label: 'Tabel For Finish Quality Tmg Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TabelForFinishQuali_S
  as select from I_Language
    left outer join ZDM_SORTMASTER on 0 = 0
  composition [0..*] of ZI_TabelForFinishQuali as _TabelForFinishQuali
{
  key 1 as SingletonID,
  _TabelForFinishQuali,
  max( ZDM_SORTMASTER.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
