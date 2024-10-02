@EndUserText.label: 'ZPACKD SCREEN TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_ZpackdScreenOP_1
  as select from I_Language
    left outer join ZDENIM_OPRAT_TAB on 0 = 0
  composition [0..*] of ZI_ZpOPRAT_T_Dable as _ZpackScreenOPRAT_T_
{
  key 1 as SingletonID,
  _ZpackScreenOPRAT_T_,
  max( ZDENIM_OPRAT_TAB.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
