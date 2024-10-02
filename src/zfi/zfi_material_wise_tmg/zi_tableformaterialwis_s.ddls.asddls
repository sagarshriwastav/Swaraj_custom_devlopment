@EndUserText.label: 'Table For Material Wise Tmg Fi Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZI_TableForMaterialWis_S
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZI_TABLEFORMATERIALWIS'
  composition [0..*] of ZI_TableForMaterialWis as _TableForMaterialWis
{
  key 1 as SingletonID,
  _TableForMaterialWis,
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  cast( 'X' as ABAP_BOOLEAN preserving type) as HideTransport
  
}
where I_Language.Language = $session.system_language
