@AbapCatalog.sqlViewName: 'ZPSPRJB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Project Budget Report'
define view ZPS_BUDGET_CDS
  as select from    ZPS_PROJ_BUDGET       as a
    left outer join ZPS_PURCHASE_BUDGET_1 as b on(
      a.WBSElementExternalID  = b.WBSElementExternalID
      and a.ProjectExternalID = b.ProjectExternalID
    )
    left outer join ZBUDGET_TOTAL         as c on(
      //      B.WBSElementInternalID = a.WBSElementInternalID
      c.WBSElementExternalID  = a.WBSElementExternalID
      and c.ProjectExternalID = a.ProjectExternalID
    )
{
  key a.WBSElementInternalID,
      a.WBSElementExternalID,
      a.WBSElement,
      a.ProjectExternalID,
      b.MaterialBaseUnit,
      c.GlobalCurrency                                                         as GlobalCurrency,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      c.budget_amt                                                             as Budget_amount,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      @DefaultAggregation: #SUM
      cast( b.ConditionAmount  as abap.dec( 13, 2 ) )                          as commitment_amt,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      @DefaultAggregation: #SUM
      cast( b.actual  as abap.dec( 13, 2 ) )                                   as actual_amt,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      @DefaultAggregation: #SUM
      cast( b.actual + b.ConditionAmount  as abap.dec( 13, 2 ) )               as assign_amt,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      @DefaultAggregation: #SUM
//      cast( ( c.budget_amt - ( b.actual + b.ConditionAmount ) ) as abap.dec(13,2) ) as available_amt,
      
        case when b.actual  is null and b.ConditionAmount is null then cast( c.budget_amt as abap.dec(13,2) ) 
             when b.actual  is null and b.ConditionAmount is not null then cast( c.budget_amt - b.ConditionAmount as abap.dec(13,2) ) 
             when b.actual  is not null and b.ConditionAmount is null then cast( c.budget_amt - b.actual as abap.dec(13,2) )  
             when b.actual  is not null and b.ConditionAmount is not null then cast( c.budget_amt - ( b.actual + b.ConditionAmount ) as abap.dec(13,2) ) 
             else cast( c.budget_amt as abap.dec(13,2) ) end as available_amt 
                   

}
