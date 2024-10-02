@EndUserText.label: 'ZSALES POLIC TAB'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZsalesPolicTab
  as select from zsales_polic_tab
  association to parent ZI_ZsalesPolicTab_S as _ZsalesPolicTabAll on $projection.SingletonID = _ZsalesPolicTabAll.SingletonID
{
  key plant as Plant,
  key policyno as Policyno,
  key nameofpolicyprovider as Nameofpolicyprovider,
  key policystartdate as Policystartdate,
  key policycoverageperiod as Policycoverageperiod,
  key policyrenweldate as Policyrenweldate,
  policycoverageamount as Policycoverageamount, 
  @Semantics.user.createdBy: true
  localcreatedby as Localcreatedby,      
  @Semantics.systemDateTime.createdAt: true
  localcreatedat as Localcreatedat,
  @Semantics.user.localInstanceLastChangedBy: true
  locallastchangedby as Locallastchangedby,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  locallastchangedat as Locallastchangedat,
  @Semantics.systemDateTime.lastChangedAt: true
  lastchangedat as Lastchangedat,
  1 as SingletonID,
  _ZsalesPolicTabAll
  
}
