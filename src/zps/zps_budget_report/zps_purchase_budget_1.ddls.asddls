@AbapCatalog.sqlViewName: 'ZPS_PURCHASE_1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Budget Report'
define view ZPS_PURCHASE_BUDGET_1
  as select from ZPS_PURCHASE_BUDGET as A
    left outer join ZBUDGET_TOTAL         as c on(
      //      B.WBSElementInternalID = a.WBSElementInternalID
      c.WBSElementExternalID  = A.WBSElementExternalID
      and c.ProjectExternalID = A.ProjectExternalID
    )
{
  key
      A.WBSElementInternalID,
      A.WBSElementExternalID,
      A.ProjectExternalID,
      A.WBSElement,
      A.MaterialBaseUnit,
      A.budget_amt                             as budget_amt,
      A.ConditionAmount                        as ConditionAmount,
      A.ConditionTotalAmount   as actual

}
