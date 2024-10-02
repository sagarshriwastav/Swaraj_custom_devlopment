@EndUserText.label: 'MAINTAIN STOCK TMG Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: [ 'SingletonID' ]
define root view entity ZI_MaintainStockTmg_S
  as select from I_Language
    left outer join ZSTOCK_TMG on 0 = 0
  composition [0..*] of ZI_MaintainStockTmg as _MaintainStockTmg
{
  key 1 as SingletonID,
  _MaintainStockTmg,
  max( ZSTOCK_TMG.LOCAL_LAST_CHANGED_AT ) as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
