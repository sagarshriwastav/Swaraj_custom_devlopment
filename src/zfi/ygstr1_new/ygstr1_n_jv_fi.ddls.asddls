@AbapCatalog.sqlViewName: 'YGSTR1JV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1_JV_DOCUMENT'
define view YGSTR1_N_JV_FI as select from YGSTR1_JV_FI_1 as a 
  left outer join ZFI_PROFITCENTER as C on  C.CompanyCode       = a.CompanyCode
                                                 and C.FiscalYear         = a.FiscalYear
                                                 and C.AccountingDocument = a.AccountingDocument    
                                                  
{
    key a.CompanyCode,
    key a.FiscalYear,
    key a.AccountingDocument,
    a.PostingDate,
    a.AccountingDocumentType,
    a.CompanyCodeCurrency,
    a.TransactionCurrency,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    case a.IsReversal when 'X' then 
    (sum(a.CGST) * -1 ) else sum(CGST) end as CGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'
     case a.IsReversal when 'X' then 
    (sum(a.SGST) * -1 ) else sum(SGST) end as SGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
     case a.IsReversal when 'X' then 
    (sum(a.IGST) * -1 ) else sum(IGST) end as IGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    case a.IsReversal when 'X' then 
    (sum(a.TaxBaseAmountInCoCodeCrcy) * -1 ) else sum(a.TaxBaseAmountInCoCodeCrcy) end as TaxBaseAmountInCoCodeCrcy,
    a.AccountingDocumentItemType,
    a.TaxCode,
    a.BillingDocument,
    a.IN_HSNOrSACCode,
    a.Customer,
    a.Reference1IDByBusinessPartner,
    a.Reference2IDByBusinessPartner,
    a.AccountingDocumentHeaderText,
    a.DocumentItemText, 
    a.DocumentReferenceID,
    a.TransactionCode,
    a.gstrate,
    a.Taxcodedescription,
    a.IsReversal,
    a.IsReversed,
    a.ReversalReferenceDocument,
    a.TaxNumber3,
    a.Region,
    CustomerName,
    C.BusinessPlace,
    C.ProfitCenter
}

group by
      a.CompanyCode,
      a.FiscalYear,
      a.AccountingDocument,
      a.PostingDate,
      a.AccountingDocumentType,
      a.CompanyCodeCurrency,
      a.TransactionCurrency,
      a.AccountingDocumentItemType,
      a.TaxBaseAmountInCoCodeCrcy,
      a.TaxCode,
      a.BillingDocument,
      a.IN_HSNOrSACCode,
      a.Customer,
      a.Reference1IDByBusinessPartner,
      a.Reference2IDByBusinessPartner,
      a.AccountingDocumentHeaderText,
      a.DocumentItemText, 
      a.DocumentReferenceID,
      a.TransactionCode,
      a.gstrate,
      a.Taxcodedescription,
      a.IsReversal,
      a.IsReversed ,
      a.ReversalReferenceDocument ,
      a.TaxNumber3,
      a.Region,
      a.CustomerName,
      C.BusinessPlace,
      C.ProfitCenter
