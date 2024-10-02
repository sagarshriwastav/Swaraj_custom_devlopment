@AbapCatalog.sqlViewName: 'YJVGSTR2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gstr2 Report'
define view YGSTR2_JV_DOCUMENT_1 as select from YGSTR2_JV_DOCUMENT 

{
      key FiDocument,
      key FiscalYear,
      FiDocumentItem,
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
      Gross_amount ,
      TaxCode,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      InvoceValue ,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( igst )            as IGST,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( cgst )            as CGST,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      sum( Sgst )            as SGST,
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
InvoceValue ,
Gross_amount,
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
