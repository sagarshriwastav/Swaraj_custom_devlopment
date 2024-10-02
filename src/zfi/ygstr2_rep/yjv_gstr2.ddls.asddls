@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YJV_DOCUMENT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YJV_GSTR2 as select from YGSTR2_JV_DOCUMENT_1 

{
      key FiDocument,
      key FiscalYear,
      '' as FiDocumentItem,
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
      substring(DocumentReferenceID,instr(DocumentReferenceID,'_'),(instr(DocumentReferenceID,'_')-1))as TEST,
      ReversalReferenceDocument,
      PARTYcODE,
      PLACE_SUPPLY,
      IN_GSTSupplierClassification,
      PartyName,
      GstIn,
      State,
      TaxRate,
      Taxcodedescription
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
Taxcodedescription  
