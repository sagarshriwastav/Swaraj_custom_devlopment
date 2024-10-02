@AbapCatalog.sqlViewName: 'YPROFITCENTER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Operational ProfitCenter'
define view ZI_Operational_PROFITCENTER as select from I_OperationalAcctgDocItem
{
    key AccountingDocument,
    key FiscalYear,
    key CompanyCode,
        ProfitCenter
}   
   where ProfitCenter <> '' 
   group by 
         AccountingDocument,
         FiscalYear,
         CompanyCode,
         ProfitCenter
