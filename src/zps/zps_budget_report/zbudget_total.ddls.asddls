@AbapCatalog.sqlViewName: 'ZBUDGET_TOTAL1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Budget Report'
define view ZBUDGET_TOTAL
  as select from ZPS_PROJ_BUDGET
{
  WBSElement,
  WBSElementInternalID,
  WBSElementExternalID,
  ProjectExternalID,
  GlobalCurrency                as GlobalCurrency,
  @Semantics.amount.currencyCode: 'GlobalCurrency'
  cast( sum( AmountInGlobalCurrency ) as abap.dec(13,2) ) as budget_amt
}
group by
  WBSElement,
  WBSElementInternalID,
  WBSElementExternalID,
  GlobalCurrency,
  CompanyCodeCurrency,
  ProjectExternalID
