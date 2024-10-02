@EndUserText.label: 'ZEPCG OBLIGATION'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZepcgObligation
  as select from ZEPCG_OBLIGATION
  association to parent ZI_ZepcgObligation_S as _ZepcgObligationAll on $projection.SingletonID = _ZepcgObligationAll.SingletonID
{
  key EPCG_LICENSE_NO as EpcgLicenseNo,
  key VALID_FROM as ValidFrom,
  key VALID_TO as ValidTo,
  EXPORT_OBLIGATION as ExportObligation,
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
  _ZepcgObligationAll
  
}
