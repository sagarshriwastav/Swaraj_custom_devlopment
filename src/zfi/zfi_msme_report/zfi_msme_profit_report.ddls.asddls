@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For MSME Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_MSME_PROFIT_REPORT as select from I_OperationalAcctgDocItem
{
    key AccountingDocument,
    key FiscalYear,
    key CompanyCode,
        Plant,
        ProfitCenter
} where Plant <> ''
group by 
  AccountingDocument,
  FiscalYear,
  CompanyCode,
  Plant,
  ProfitCenter
