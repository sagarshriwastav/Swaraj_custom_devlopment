//@AbapCatalog.sqlViewName: 'YMSMEREP'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Cds For Msme Report'
//define view 
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Wise  Report'
define root view entity
ZFI_MSME_REPORT as select from I_OperationalAcctgDocItem as a 
 left outer join I_Supplier as b on (b.Supplier = a.Supplier )
 left outer join I_SupplierCompany as C on ( C.Supplier = a.Supplier and C.CompanyCode = a.CompanyCode  )
 left outer join I_ClfnObjectCharcValForKeyDate( P_KeyDate:$session.system_date  ) 
                                   as d on ( d.ClfnObjectID = a.Supplier and d.ClfnObjectTable = 'LFA1'
                                   and d.ClassType = '010' )
 left outer join I_JournalEntry as e on ( e.AccountingDocument = a.AccountingDocument and e.CompanyCode = a.CompanyCode 
                                           and e.FiscalYear = a.FiscalYear )  
 left outer join I_OperationalAcctgDocItem as f on ( f.AccountingDocument = a.AccountingDocument and f.CompanyCode = a.CompanyCode 
                                                and f.FiscalYear = a.FiscalYear and ( f.TransactionTypeDetermination = 'WRX' 
                                                or  f.TransactionTypeDetermination = 'BSX' or f.TransactionTypeDetermination = 'KBS' 
                                                or  f.TransactionTypeDetermination = 'PK2' or  f.TransactionTypeDetermination = 'PK1'
                                                or  f.TransactionTypeDetermination = 'FR3' or f.TransactionTypeDetermination = 'ANL' 
                                                ) and f.PurchasingDocument is not initial )                                                                          
 
 left outer join ZFI_MSME_PROFIT_REPORT as G on ( G.AccountingDocument = a.AccountingDocument and G.CompanyCode = a.CompanyCode 
                                           and G.FiscalYear = a.FiscalYear )  
                                           
{
  key a.AccountingDocument,
  key a.FiscalYear,
  key a.CompanyCode,
  key a.PostingDate,   
      a.Supplier,
      left(a.OriginalReferenceDocument,10) as OriginalReferenceDocument,
      e.DocumentReferenceID as InvoiceReference,  
      a.DocumentDate,    
      a.BusinessPlace,
      a.PaymentTerms,
      f.PurchasingDocument,
      a.TransactionCurrency,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      a.AmountInCompanyCodeCurrency  ,
      b.SupplierName,
      C.MinorityGroup,
      d.CharcValue,
      a.AccountingDocumentType,
      a.DocumentItemText,
      G.ProfitCenter,
      G.Plant,
      case when dats_days_between( a.DueCalculationBaseDate, $session.system_date ) > 0
               then dats_days_between( a.DueCalculationBaseDate, $session.system_date )
               else dats_days_between( a.DueCalculationBaseDate, $session.system_date ) * -1 end as zdays
      
}  

where 
   a.FinancialAccountType = 'K' 
   and a.ClearingJournalEntry = '' and a.SpecialGLCode <> 'F'

   group by 
   
    a.AccountingDocument,
    a.FiscalYear,
    a.CompanyCode,
    a.PostingDate,   
    a.Supplier,
    a.OriginalReferenceDocument,
    e.DocumentReferenceID ,  
    a.DocumentDate,    
    a.BusinessPlace,
    a.PaymentTerms,
    f.PurchasingDocument,
    a.TransactionCurrency,
    a.AmountInCompanyCodeCurrency  ,
    a.AccountingDocumentType,
    a.DocumentItemText,
    b.SupplierName,
    C.MinorityGroup,
    d.CharcValue,
    G.ProfitCenter,
    G.Plant,
    a.DueCalculationBaseDate
