@AbapCatalog.sqlViewName: 'YZSSR_REPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSSR_REPORT'
define view ZSSR_REPORT as select from I_BillingDocumentItemPrcgElmnt
{
    key BillingDocument,
    key BillingDocumentItem,
   // key PricingProcedureStep,
  //  key PricingProcedureCounter,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum( ConditionRateValue )  as ConditionRateValue, 
    ConditionCurrency,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum(ConditionAmount)  as  ConditionAmount,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum(ConditionRateAmount)  as  ConditionRateAmount,
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum(ConditionBaseAmount)  as  ConditionBaseAmount, 
    @Semantics.amount.currencyCode: 'ConditionCurrency'
    sum(ConditionBaseValue)   as  ConditionBaseValue,
    ConditionInactiveReason,
   ConditionBaseValue  as DiscountAmount,
   ConditionRateValue as DiacountPersantage
    
}
where
   ( ConditionType =  'ZR00' or ConditionType = 'ZPIC' or ConditionType = 'ZD04' or ConditionType = 'ZD05'  ) 
  and ConditionRateValue is not initial and ConditionInactiveReason = ''
     
  group by
      BillingDocument,
      BillingDocumentItem,
      PricingProcedureStep,
      PricingProcedureCounter,
      ConditionCurrency,
      ConditionInactiveReason,
      ConditionType,
      ConditionBaseValue,
      ConditionRateValue
