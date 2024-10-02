@AbapCatalog.sqlViewName: 'YPAYMENTADVICE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Payment Advice Report'
define view YFI_PAYMENT_PROFITCENTER as select from I_JournalEntryItem

{
    key AccountingDocument,
    key FiscalYear,
    key CompanyCode,
        ProfitCenter
      
}    
  where ProfitCenter <> 'YB900' and ProfitCenter <> '' and ( HouseBank  <> '' or ( GLAccount = '2200001800' or GLAccount = '2200001900' or 
  GLAccount = '2200002000' or GLAccount = '2200002100' ) )
 group by  
        AccountingDocument,
        FiscalYear,
        CompanyCode,
        ProfitCenter
