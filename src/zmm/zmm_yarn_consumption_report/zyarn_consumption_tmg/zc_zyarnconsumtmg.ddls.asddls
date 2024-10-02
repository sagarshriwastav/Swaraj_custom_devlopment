@EndUserText.label: 'Maintain ZYARN CONSUM TMG'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZyarnConsumTmg
  as projection on ZI_ZyarnConsumTmg
{
  key Fabric,
  key Yarn,
  key Pick,
  Localcreatedby,
  Localcreatedat,
  @Consumption.hidden: true
  Locallastchangedby,
  @Consumption.hidden: true
  Locallastchangedat,
  Lastchangedat,
  @Consumption.hidden: true
  SingletonID,
  _ZyarnConsumTmgAll : redirected to parent ZC_ZyarnConsumTmg_S
  
}
