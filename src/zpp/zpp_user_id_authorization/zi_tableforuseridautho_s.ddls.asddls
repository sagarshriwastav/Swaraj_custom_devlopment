@EndUserText.label: 'Table For User Id Authorization Singleto'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TableForUserIdAutho_S
  as select from I_Language
    left outer join ZPP_USER_TABLE on 0 = 0
  composition [0..*] of ZI_TableForUserIdAutho as _TableForUserIdAutho
{
  key 1 as SingletonID,
  _TableForUserIdAutho,
  max( ZPP_USER_TABLE.LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
