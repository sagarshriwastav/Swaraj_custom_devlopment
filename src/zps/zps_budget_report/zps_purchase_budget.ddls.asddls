@AbapCatalog.sqlViewName: 'ZPS_PURCHASE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Budget Report'
define view ZPS_PURCHASE_BUDGET
  as select from //  ZPURCHASE_INV_DETAIL           as a
                    I_PurOrdAccountAssignmentAPI01 as a 
    left outer join ZPS_BUDGET_CDS3                   as c on  c.PurchaseOrder     = a.PurchaseOrder
                                                        and c.PurchaseOrderItem = a.PurchaseOrderItem 
    left outer join  I_PurOrdItmPricingElementAPI01 as b on  b.PurchaseOrder     = a.PurchaseOrder
                                                        and b.PurchaseOrderItem = a.PurchaseOrderItem 
                                                        and ( c.MaterialDocument is null  or c.MaterialDocument = ' ' )
    left outer join  I_PurOrdItmPricingElementAPI01 as f on  f.PurchaseOrder     = a.PurchaseOrder
                                                        and f.PurchaseOrderItem = a.PurchaseOrderItem 
                                                        and ( c.MaterialDocument <> ' ' or c.MaterialDocument is not null )
    inner join      ZPS_PROJ_BUDGET                as d on(
      d.WBSElementInternalID = a.WBSElementInternalID
    )
{

  a.WBSElementInternalID          as WBSElementInternalID,
  d.WBSElementExternalID          as WBSElementExternalID,
  d.ProjectExternalID             as ProjectExternalID,
  sum( f.ConditionAmount )        as ConditionTotalAmount,
  ''                              as MaterialBaseUnit,
  sum( b.ConditionAmount )     as ConditionAmount,
  d.WBSElement                    as WBSElement,
  sum( d.AmountInGlobalCurrency ) as budget_amt
}
group by  
  a.WBSElementInternalID,
  d.WBSElementExternalID,
  d.ProjectExternalID,
  d.WBSElement
