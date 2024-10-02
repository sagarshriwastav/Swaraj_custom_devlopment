@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Budget Report Amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPS_PROJ_BUDGET   as select from I_ActualPlanJournalEntryItem
  
{
  key WBSElement,
      WBSElementExternalID,
      WBSElementInternalID,
      CompanyCodeCurrency,
      ProjectExternalID,
      @Semantics.amount.currencyCode: 'GlobalCurrency'
      sum (AmountInGlobalCurrency) as AmountInGlobalCurrency,
      GlobalCurrency               as GlobalCurrency,
      CompanyCode                  as CompanyCode,
//      FiscalYear                   as FiscalYear,
      ProfitCenter                 as /SAP/1_PROFITCENTER


}
where
  PlanningCategory = 'PLN'

group by

  WBSElement,
  WBSElementExternalID,
  WBSElementInternalID,
  CompanyCodeCurrency,
  GlobalCurrency,
  CompanyCode,
  ProfitCenter,
  ProjectExternalID
