@AbapCatalog.sqlViewName: 'YYJV_GSTR2RECON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gstr2 Recon'
define view YJV_GSTR2_RECON as select from YGSTR2_JV_DOCUMENT_1
{
   key FiDocument,
      key FiscalYear,
      FiDocumentItem as FiDocumentItem,
      DocumentDate,    
      TransactionCurrency,
      CompanyCode,
      Refrence_No,
      AccountingDocumentType,
      PostingDate,
      BusinessPlace,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( TaxableValue )  as   TaxableValue,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(Gross_amount )  as Gross_amount,
      TaxCode,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum(InvoceValue )  as InvoceValue,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( IGST )            as IGST,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( CGST )            as CGST,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( SGST )            as SGST,
      DebitCreditCode,
      IsReversed,
      AccountingDocumentHeaderText,
      DocumentReferenceID,
      ReversalReferenceDocument,
      PARTYcODE,
      PLACE_SUPPLY,
      IN_GSTSupplierClassification,
      PartyName,
      GstIn,
      State,
      TaxRate,
      Taxcodedescription,
      GLAccount
}
   group by
   

FiDocument,
FiscalYear,
FiDocumentItem,         
DocumentDate,           
TransactionCurrency  ,  
CompanyCode, 
BusinessPlace,             
Refrence_No,            
AccountingDocumentType, 
//InvoceValue ,
//Gross_amount,
TaxCode,
PostingDate,
DebitCreditCode,
IsReversed,
AccountingDocumentHeaderText,
DocumentReferenceID, 
ReversalReferenceDocument,
PARTYcODE,                
PLACE_SUPPLY,
IN_GSTSupplierClassification,
PartyName,
GstIn,
State,
TaxRate,
Taxcodedescription,
GLAccount  
