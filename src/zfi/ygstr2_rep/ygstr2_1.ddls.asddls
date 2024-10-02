@AbapCatalog.sqlViewName: 'YGST12_1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gstr2 Report'
define view YGSTR2_1 as select from YGSTR2 as a

  
{
    key a.FiDocument,
    key a.FiscalYear,   
    key a.CompanyCode,
    a.FiDocumentItem,
    a.DocumentDate,
    a.TransactionCurrency  ,
    a.Mironumber,
    a.MiroYear, 
    a.Refrence_No,
    a.AccountingDocumentType,
    a.PostingDate,
    a.HsnCode,
    a.AssignmentReference,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.InvoceValue,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.TaxableValue,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.Gross_amount ,
    a.TaxCode,   
    @Semantics.amount.currencyCode: 'TransactionCurrency' 
    sum( a.igst )                     as IGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum( a.cgst )                     as CGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum( a.Sgst )                     as SGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum( a.RCM_igst )                 as RCMI,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.RCM_cgst)                   as RCMC,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.RCM_Sgst)                   as RCMS,
    a.PARTYcODE,
    a.PlaceofSupply,
    a.FinancialAccountType,
    a.IN_GSTSupplierClassification,
    a.PartyName,
    a.GstIn,
    a.State,
    a.TaxRate,
    a.Taxcodedescription,
    a.AccountingDocumentHeaderText,
    a.DocumentReferenceID,
    a.IsReversed,
    a.BusinessPlace,
    a.ReversalReferenceDocument,
    
    a.Quantity,
    a.BaseUnit,
    a.PartyAdd
    
  // a.GLAccount
    
    
}

   group by
  
    a.FiDocument,
    a.FiscalYear,
    a.CompanyCode,
    a.FiDocumentItem,
    a.DocumentDate,
    a.TransactionCurrency,
    a.Mironumber,
    a.MiroYear,
    a.Refrence_No,
    a.AccountingDocumentType,
    a.PostingDate,
    a.HsnCode,
    a.AssignmentReference,
    a.InvoceValue,
    a.TaxableValue,
    a.Gross_amount,
    a.TaxCode,
    a.PARTYcODE,
    a.PlaceofSupply,
    a.FinancialAccountType,
    a.IN_GSTSupplierClassification,   
    a.PartyName,
    a.GstIn,
    a.State,
    a.TaxRate,
    a.Taxcodedescription,
    a.AccountingDocumentHeaderText,
    a.DocumentReferenceID,
    a.IsReversed,
    a.BusinessPlace,
    a.ReversalReferenceDocument,
    
    a.Quantity,
    a.BaseUnit,
    a.PartyAdd
    
   // a.GLAccount
    
    
    
