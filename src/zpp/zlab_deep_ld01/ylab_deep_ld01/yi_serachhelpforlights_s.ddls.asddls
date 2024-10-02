@EndUserText.label: 'SERACH HELP FOR LIGHT SOURCE Singleton'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: [ 'SingletonID' ]
@UI: {
  headerInfo: {
    typeName: 'SerachHelpForLigAll'
  }
}
define root view entity YI_SerachHelpForLightS_S
  as select from I_Language
    left outer join YLIGHTSOUEF4_TMG on 0 = 0
  association [0..*] to I_ABAPTransportRequestText as _I_ABAPTransportRequestText on $projection.TransportRequestID = _I_ABAPTransportRequestText.TransportRequestID
  composition [0..*] of YI_SerachHelpForLightS as _SerachHelpForLightS
{
  @UI.facet: [ {
    id: 'YI_SerachHelpForLightS', 
    purpose: #STANDARD, 
    type: #LINEITEM_REFERENCE, 
    label: 'SERACH HELP FOR LIGHT SOURCE', 
    position: 1 , 
    targetElement: '_SerachHelpForLightS'
  } ]
  @UI.lineItem: [ {
    position: 1 
  } ]
  key 1 as SingletonID,
  _SerachHelpForLightS,
  @UI.hidden: true
  max( YLIGHTSOUEF4_TMG.LOCAL_LAST_CHANGED_AT ) as LastChangedAtMax,
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
