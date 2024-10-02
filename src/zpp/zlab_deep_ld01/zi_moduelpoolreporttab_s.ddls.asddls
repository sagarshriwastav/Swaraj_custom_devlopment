@EndUserText.label: 'MODUELPOOL REPORT TABLE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'ModuelpoolReportAll'
  }
}
define root view entity ZI_ModuelpoolReportTab_S
  as select from I_Language
    left outer join I_CstmBizConfignLastChgd on I_CstmBizConfignLastChgd.ViewEntityName = 'ZI_MODUELPOOLREPORTTAB'
  association [0..*] to I_ABAPTransportRequestText as _I_ABAPTransportRequestText on $projection.TransportRequestID = _I_ABAPTransportRequestText.TransportRequestID
  composition [0..*] of ZI_ModuelpoolReportTab as _ModuelpoolReportTab
{
  @UI.facet: [ {
    id: 'ZI_ModuelpoolReportTab', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'MODUELPOOL REPORT TABLE', 
    position: 1 , 
    targetElement: '_ModuelpoolReportTab'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _ModuelpoolReportTab,
  @UI.hidden: true
  I_CstmBizConfignLastChgd.LastChangedDateTime as LastChangedAtMax,
  @ObjectModel.text.association: '_I_ABAPTransportRequestText'
  @UI.identification: [ {
    position: 2 , 
    type: #WITH_INTENT_BASED_NAVIGATION, 
    semanticObjectAction: 'manage'
  } ]
  @Consumption.semanticObject: 'CustomizingTransport'
  cast( '' as SXCO_TRANSPORT) as TransportRequestID,
  _I_ABAPTransportRequestText
  
}
where I_Language.Language = $session.system_language