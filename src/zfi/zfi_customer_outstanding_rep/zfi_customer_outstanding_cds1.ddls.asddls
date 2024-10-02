@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Customer Outstanding Report'
define root view entity ZFI_CUSTOMER_OUTSTANDING_CDS1 as select from  I_OperationalAcctgDocItem  as a
{
 key  a.CompanyCode,
 key  a.FiscalYear, 
 key  a.AccountingDocument,    
      a.Customer,
      a.Product,
      a.ProfitCenter,
      a.SalesDocument,
      a.SalesDocumentItem
} where ( a.AccountingDocumentType = 'RV' or a.AccountingDocumentType = 'DR' 
         or a.AccountingDocumentType = 'DG' or a.AccountingDocumentType = 'D9' 
          or a.AccountingDocumentType = 'AA' or a.AccountingDocumentType = 'SA'  
          or a.AccountingDocumentType = 'UE' or a.AccountingDocumentType = 'DA' )
   and ( a.AccountingDocumentItemType = 'W' or a.Material <> '' or a.FinancialAccountType = 'A'
       or a.FinancialAccountType = 'L')  and a.AccountingDocumentItemType <> 'T' 
       
       group by 
       a.CompanyCode,
       a.FiscalYear,
       a.AccountingDocument,    
       a.Customer,
       a.Product,
       a.ProfitCenter,
       a.SalesDocument,
       a.SalesDocumentItem
