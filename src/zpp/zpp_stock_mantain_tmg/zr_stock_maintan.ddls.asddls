@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZSTOCK_MAINTAN'
define root view entity ZR_STOCK_MAINTAN
  as select from zstock_maintan
{
  key party_code as PartyCode,
  opening_balance as OpeningBalance,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
  
}
