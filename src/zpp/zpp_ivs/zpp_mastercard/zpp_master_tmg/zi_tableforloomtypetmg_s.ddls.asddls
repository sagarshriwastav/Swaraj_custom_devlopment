@EndUserText.label: 'Table For Loom Type  Tmg Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TableForLoomTypeTmg_S
  as select from I_Language
    left outer join ZLOOM_TYPE on 0 = 0
  composition [0..*] of ZI_TableForLoomTypeTmg as _TableForLoomTypeTmg
{
  key 1 as SingletonID,
  _TableForLoomTypeTmg,
  max( ZLOOM_TYPE.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
