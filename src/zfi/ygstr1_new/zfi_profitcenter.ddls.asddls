@AbapCatalog.sqlViewName: 'YFIPROFIT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For ProfitCenter'
define view ZFI_PROFITCENTER as select from I_OperationalAcctgDocItem as a 
{
    key a.CompanyCode,
    key a.FiscalYear,
    key a.AccountingDocument,
        a.BusinessPlace,
        a.ProfitCenter
      
}   
  where a.FinancialAccountType = 'S' and  a.ProfitCenter <> '' 
   group by  
        a.CompanyCode,
        a.FiscalYear,
        a.AccountingDocument,
        a.BusinessPlace,
        a.ProfitCenter
