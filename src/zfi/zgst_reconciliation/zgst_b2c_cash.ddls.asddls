@EndUserText.label: 'B2C Cash Discount Report'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity zgst_b2c_cash as select from I_OperationalAcctgDocItem as a
inner join I_Supplier as b on a.Supplier = b.Supplier
inner join I_JournalEntry as C on ( a.AccountingDocument = C.AccountingDocument and a.FiscalYear = C.FiscalYear 
                               and a.CompanyCode = C.CompanyCode )
{
 a.AccountingDocument ,
 a.CompanyCode,
 a.FiscalYear ,
 a.Supplier   ,
 a.AccountingDocumentType,
 b.SupplierName ,
 b.TaxNumber3 ,
 C.DocumentReferenceID
} 
where ( a.AccountingDocumentType = 'SK'
    or  a.AccountingDocumentType = 'KR'
     or  a.AccountingDocumentType = 'RE'
     or  a.AccountingDocumentType = 'AA' ) and b.TaxNumber3 is initial 
