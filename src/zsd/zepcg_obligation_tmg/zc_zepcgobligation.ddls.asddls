@EndUserText.label: 'Maintain ZEPCG OBLIGATION'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZepcgObligation
  as projection on ZI_ZepcgObligation
{
  key EpcgLicenseNo,
  key ValidFrom,
  key ValidTo,
  ExportObligation,
  Localcreatedby,
  Localcreatedat,
  @Consumption.hidden: true
  Locallastchangedby,
  @Consumption.hidden: true
  Locallastchangedat,
  Lastchangedat,
  @Consumption.hidden: true
  SingletonID,
  _ZepcgObligationAll : redirected to parent ZC_ZepcgObligation_S
  
}
