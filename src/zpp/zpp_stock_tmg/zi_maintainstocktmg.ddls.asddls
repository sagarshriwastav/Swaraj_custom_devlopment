@EndUserText.label: 'MAINTAIN STOCK TMG'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZI_MaintainStockTmg
  as select from zstock_tmg
  association to parent ZI_MaintainStockTmg_S as _MaintainStockTmgAll on $projection.SingletonID = _MaintainStockTmgAll.SingletonID
{
  key party_code as PartyCode,
  opening_balance as OpeningBalance,
  postingdate   as postingdate,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  @Consumption.hidden: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  @Consumption.hidden: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Consumption.hidden: true
  1 as SingletonID,
  _MaintainStockTmgAll
  
}
