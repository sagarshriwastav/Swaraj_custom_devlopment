@AbapCatalog.sqlViewName: 'YGSTR1JV1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1_JV'
define view YGSTR1_JV_FI_1 as select from YGSTR1_JV_FI
{
    key CompanyCode,
    key FiscalYear,
    key AccountingDocument,
    PostingDate,
    AccountingDocumentType,
    CompanyCodeCurrency,
    TransactionCurrency,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
     case AccountingDocumentType when 'DG' then 
     (sum( CGST ) * -1 ) else sum( CGST ) end as CGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
     case AccountingDocumentType when 'DG' then 
     (sum( SGST ) * -1 ) else sum( SGST ) end as SGST,
   @Semantics.amount.currencyCode: 'TransactionCurrency'
    case AccountingDocumentType when 'DG' then 
    (sum( IGST ) * -1 ) else sum( IGST ) end as IGST,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    case AccountingDocumentType when 'DG' then 
    ( ( TaxBaseAmountInCoCodeCrcy ) * -1 ) else ( TaxBaseAmountInCoCodeCrcy ) end as TaxBaseAmountInCoCodeCrcy,    
    AccountingDocumentItemType,
    TaxCode,
    BillingDocument,
    IN_HSNOrSACCode,
    Customer,
    Reference1IDByBusinessPartner,
    Reference2IDByBusinessPartner,
    AccountingDocumentHeaderText,
    DocumentItemText,
    DocumentReferenceID,
    TransactionCode,
    gstrate,
    Taxcodedescription,
    IsReversal,
    IsReversed,
    ReversalReferenceDocument,
    TaxNumber3,
    Region,
    CustomerName
}

group by
      CompanyCode,
      FiscalYear,
      AccountingDocument,
      PostingDate,
      AccountingDocumentType,
      CompanyCodeCurrency,
      TransactionCurrency,
      AccountingDocumentItemType,
      TaxBaseAmountInCoCodeCrcy,
      TaxCode,
      BillingDocument,
      IN_HSNOrSACCode,
      Product,
      Customer,
      Reference1IDByBusinessPartner,
      Reference2IDByBusinessPartner,
      DocumentItemText,
      AccountingDocumentHeaderText,      
      DocumentReferenceID,
      TransactionCode,
      gstrate,
      Taxcodedescription,
      IsReversal,
      IsReversed ,
      ReversalReferenceDocument ,
      TaxNumber3,
      Region,
      CustomerName
