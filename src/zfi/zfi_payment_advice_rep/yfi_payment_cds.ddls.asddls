@AbapCatalog.sqlViewName: 'YPAYMENT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Payment Advice Report'
    define view YFI_PAYMENT_CDS as select from  I_OperationalAcctgDocItem as a 
    left outer join I_OperationalAcctgDocItem as c on ( c.AccountingDocument = a.AccountingDocument and c.CompanyCode = a.CompanyCode 
                         and c.FiscalYear = a.FiscalYear and c.FinancialAccountType = 'K' and c.DocumentItemText <> '' )
    left outer join I_OperationalAcctgDocItem as D on ( D.AccountingDocument = a.AccountingDocument and D.CompanyCode = a.CompanyCode 
                         and D.FiscalYear = a.FiscalYear and D.FinancialAccountType = 'D' and D.DocumentItemText <> '' )
    left outer  join I_Supplier as b on ( b.Supplier = c.Supplier  )  
    left outer  join I_Customer as e on ( e.Customer = D.Customer  ) 
    left outer join I_JournalEntry as f on ( f.AccountingDocument = a.AccountingDocument and f.FiscalYear = a.FiscalYear and f.CompanyCode = a.CompanyCode ) 
    left outer join I_OperationalAcctgDocItem as h on ( h.AccountingDocument = a.AccountingDocument and h.CompanyCode = a.CompanyCode 
                         and h.FiscalYear = a.FiscalYear and h.DebitCreditCode <> 'H' and D.Customer is null and c.Supplier is null )
    left outer join I_GLAccountText as g on  ( g.GLAccount = h.GLAccount and g.Language = 'E' )
    
               
{
 key a.AccountingDocument,
 key a.FiscalYear,
 key a.CompanyCode,
     case when c.Supplier <> '' then c.Supplier when D.Customer <> '' then D.Customer else h.GLAccount end as PartyCode,
     case when c.Supplier <> '' then b.SupplierName when D.Customer <> '' then
     e.CustomerName  else // when ( c.Supplier = ' ' and D.Customer = ' '  )
     g.GLAccountName end as PartyName,
     c.Supplier,
     c.SpecialGLCode,
 //    c.DocumentItemText,
     case when c.Supplier <> '' then c.DocumentItemText when D.Customer <> '' then D.DocumentItemText else h.DocumentItemText end as DocumentItemText,
     D.Customer,
     a.TransactionCurrency,
     a.AccountingDocumentType,
     a.PostingDate,
     a.HouseBank,  
     @Semantics.amount.currencyCode: 'TransactionCurrency'
     case when a.AccountingDocumentType = 'KZ' then 
     a.AmountInCompanyCodeCurrency  end as TRANCATIONAMOUNT,
     @Semantics.amount.currencyCode: 'TransactionCurrency'
     case when a.AccountingDocumentType = 'KZ' then 
     a.AmountInCompanyCodeCurrency else 0 end as PaymentTransferred,
     @Semantics.amount.currencyCode: 'TransactionCurrency'
     case when a.AccountingDocumentType = 'DZ' then 
     a.AmountInCompanyCodeCurrency else 0 end as PaymentReceived
     
     
     
 
    
}
    where ( ( ( a.AccountingDocumentType = 'KZ' and a.DebitCreditCode = 'H' ) or ( a.AccountingDocumentType = 'DZ' and a.DebitCreditCode = 'S' ) )
     and ( ( a.FinancialAccountType <> 'K' and a.HouseBank <> '' and a.FinancialAccountType <> 'D'  ) 
    // or  (   a.GLAccount = '2200001800' or a.GLAccount = '2200001900' or a.GLAccount = '2200002000' or a.GLAccount = '2200002100' ) 
    )  and f.IsReversal <> 'X' and f.IsReversed <> 'X' )
    
 group by 
 
     a.AccountingDocument,
     a.FiscalYear,
     a.CompanyCode,
     c.Supplier,
     D.Customer,
     b.SupplierName,
     e.CustomerName , 
     g.GLAccountName ,
     c.Supplier,
     c.SpecialGLCode,
     c.DocumentItemText,
     D.DocumentItemText,
     h.DocumentItemText,
     a.TransactionCurrency,
     a.AccountingDocumentType,
     a.PostingDate,
     a.HouseBank,  
     h.GLAccount,
     a.AccountingDocumentType,
     a.AmountInCompanyCodeCurrency
