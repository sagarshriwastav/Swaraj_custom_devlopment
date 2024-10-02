@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS For Payment WorkFlow'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Z_VENDOR_CDS as select from I_OperationalAcctgDocItem as a 
      inner join I_Supplier as b on ( b.Supplier = a.Supplier )
      left outer join I_JournalEntry as c on ( c.AccountingDocument = a.AccountingDocument and c.CompanyCode = a.CompanyCode and c.FiscalYear = a.FiscalYear )
      left outer join ZSUPP_TOT as d on ( d.Supplier = a.Supplier and d.CompanyCode = a.CompanyCode )
      inner join I_SupplierAccountGroupText  as E on ( E.SupplierAccountGroup = b.SupplierAccountGroup and E.Language = 'E' )
      left outer join ZFIPAYMENT_PROGRAM as f on ( f.Accountingdocument = a.AccountingDocument and f.Companycode = a.CompanyCode and f.Finyear = a.FiscalYear and f.Supplier = a.Supplier )
      
{
     key a.CompanyCode ,
     key a.FiscalYear ,
     key a.PostingDate ,
       a.Supplier ,
       a.AccountingDocument ,
       a.AccountingDocumentType ,
       a.ClearingJournalEntry ,
       a.TransactionCurrency ,
       @Semantics.amount.currencyCode: 'TransactionCurrency'
       a.AmountInBalanceTransacCrcy ,
       a.PaymentTerms ,
       a.DocumentItemText,
       a.NetDueDate ,
       a.AdditionalCurrency1 ,
       a.AssignmentReference ,
       a.DocumentDate,
       b.SupplierName,   
       b.SupplierAccountGroup,
       c.DocumentReferenceID,
       @Semantics.amount.currencyCode: 'TransactionCurrency'
       d.amt as SupplierAmounttot ,
       E.AccountGroupName,
       f.Request
         
    
}
 where (  a.AccountingDocumentType = 'RE' or a.AccountingDocumentType = 'KR'  ) and a.FinancialAccountType = 'K' and a.ClearingJournalEntry = ''
