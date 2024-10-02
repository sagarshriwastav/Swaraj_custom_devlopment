@EndUserText.label: 'ZBANK TMG TABLE'
@AccessControl.authorizationCheck: #CHECK
define view entity ZI_ZbankTmgTable
  as select from ZBANK_TMG_TABLE
  association to parent ZI_ZbankTmgTable_S as _ZbankTmgTableAll on $projection.SingletonID = _ZbankTmgTableAll.SingletonID
{
  key COMPANYCODE as Companycode,
  key CUSTOMER as Customer,
  PROFITCENTER as Profitcenter,
  @Semantics.user.createdBy: true
  LOCAL_CREATED_BY as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  LOCAL_CREATED_AT as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  LOCAL_LAST_CHANGED_BY as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  LOCAL_LAST_CHANGED_AT as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  LAST_CHANGED_AT as LastChangedAt,
  1 as SingletonID,
  _ZbankTmgTableAll
  
}
