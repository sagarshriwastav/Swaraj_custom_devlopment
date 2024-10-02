@EndUserText.label: 'Table For Dyeing Shade Tmg Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_DyeingShade_S
  as select from I_Language
    left outer join ZPP_DYE_SHAD_TMG on 0 = 0
  composition [0..*] of ZI_DyeingShade as _DyeingShade
{
  key 1 as SingletonID,
  _DyeingShade,
  max( ZPP_DYE_SHAD_TMG.LOCAL_LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
