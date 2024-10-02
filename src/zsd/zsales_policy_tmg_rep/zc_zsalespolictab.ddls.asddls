@EndUserText.label: 'Maintain ZSALES POLIC TAB'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZC_ZsalesPolicTab
  as projection on ZI_ZsalesPolicTab
{
  key Plant,
  key Policyno,
  key Nameofpolicyprovider,
  key Policystartdate,
  key Policycoverageperiod,
  key Policyrenweldate,
  Policycoverageamount,
  Localcreatedby,
  Localcreatedat,   
  @Consumption.hidden: true
  Locallastchangedby,
  @Consumption.hidden: true
  Locallastchangedat,
  Lastchangedat,
  @Consumption.hidden: true
  SingletonID,
  _ZsalesPolicTabAll : redirected to parent ZC_ZsalesPolicTab_S
  
}
