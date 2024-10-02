@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PMR3 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPMR3
  as select from I_ActualPlanJournalEntryItem
  
{
  key WBSElement,
      WBSElementExternalID,
      WBSElementInternalID,
      CompanyCodeCurrency,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      sum (AmountInGlobalCurrency) as AmountInGlobalCurrency,
      GlobalCurrency               as GlobalCurrency,
      CompanyCode                  as CompanyCode,
      FiscalYear                   as FiscalYear,
      ProfitCenter                 as /SAP/1_PROFITCENTER


}
where
  PlanningCategory = 'BUDGET01'

group by

  WBSElement,
  WBSElementExternalID,
  WBSElementInternalID,
  CompanyCodeCurrency,
  GlobalCurrency,
  CompanyCode,
  FiscalYear,
  ProfitCenter
