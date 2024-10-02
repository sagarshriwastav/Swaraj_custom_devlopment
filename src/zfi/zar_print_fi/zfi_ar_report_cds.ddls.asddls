@AbapCatalog.sqlViewName: 'ZFIAIRREPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Customer Outstanding Report'
define view  ZFI_AR_REPORT_CDS 
 as select from I_OperationalAcctgDocItem as a  
 left outer join I_Customer  as e on  ( e.Customer = a.Customer )
 left outer join ZI_Operational_PROFITCENTER as J on ( J.CompanyCode = a.CompanyCode and J.FiscalYear = a.FiscalYear 
                                                     and J.AccountingDocument = a.AccountingDocument)                                                                                                        
  left outer join YFI_PAYMENT_PROFITCENTER as h on ( h.CompanyCode = a.CompanyCode and h.FiscalYear = a.FiscalYear
                                                and h.AccountingDocument = a.AccountingDocument and J.ProfitCenter = '' )                                                  
{  
 key  a.CompanyCode,
 key  a.FiscalYear,
 key  a.AccountingDocument, 
      a.Customer,
      a.PostingDate,
      a.NetDueDate,
      left(a.OriginalReferenceDocument,10 ) as OriginalReferenceDocument,
      case when J.ProfitCenter <> '' then J.ProfitCenter
      else h.ProfitCenter end as  ProfitCenter,
      e.CustomerName,
      a.CompanyCodeCurrency,
      a.DueCalculationBaseDate,
      a.DocumentItemText,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum( a.AmountInCompanyCodeCurrency ) as Amount,
    $session.system_date as sydatum


} where a.FinancialAccountType = 'D'  and a.ClearingAccountingDocument = ''  
        and a.SpecialGLCode <> 'F' and a.AccountingDocumentType <> 'DZ' 
     
 group by a.CompanyCode,
          a.FiscalYear,
          a.AccountingDocument,
          a.Customer,
          a.OriginalReferenceDocument,
          h.ProfitCenter,
          J.ProfitCenter,
          a.PostingDate,
          a.NetDueDate,
          a.CompanyCodeCurrency,
          e.CustomerName,
          a.DocumentItemText,
          a.DueCalculationBaseDate
