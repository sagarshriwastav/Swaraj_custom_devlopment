@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds Job  Grey DispatcH Report'
define root view entity ZJOB_CONDITIONAMT_SUM_CDS as select from ZJOB_CONDITIONAMT_CDS

{
    key SalesDocument,
    key SalesDocumentItem,
    ConditionCurrency,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum(PIKRATE) as PIKRATE,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum(MandingCHargeS) as MandingCHargeS,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum(ROLLCHARGES) as ROLLCHARGES,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum(TotalBasicAmt) as TotalBasicAmt ,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum(IgstPercent) as IgstPercent
    
}
  group by 
      SalesDocument,
      SalesDocumentItem,
      ConditionCurrency
