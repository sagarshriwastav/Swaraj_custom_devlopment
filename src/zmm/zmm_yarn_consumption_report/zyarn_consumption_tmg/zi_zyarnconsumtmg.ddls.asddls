@EndUserText.label: 'ZYARN CONSUM TMG'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZyarnConsumTmg
  as select from ZYARN_CONSUM_TMG
  association to parent ZI_ZyarnConsumTmg_S as _ZyarnConsumTmgAll on $projection.SingletonID = _ZyarnConsumTmgAll.SingletonID
{
  key FABRIC as Fabric,
  key YARN as Yarn,
  key PICK as Pick,
  @Semantics.user.createdBy: true
  LOCALCREATEDBY as Localcreatedby,
  @Semantics.systemDateTime.createdAt: true
  LOCALCREATEDAT as Localcreatedat,
  @Semantics.user.localInstanceLastChangedBy: true
  LOCALLASTCHANGEDBY as Locallastchangedby,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCALLASTCHANGEDAT as Locallastchangedat,
  @Semantics.systemDateTime.lastChangedAt: true
  LASTCHANGEDAT as Lastchangedat,
  1 as SingletonID,
  _ZyarnConsumTmgAll
  
}
