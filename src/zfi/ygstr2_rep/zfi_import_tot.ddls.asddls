@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Ygstr2 Import Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity  ZFI_IMPORT_TOT as select from ygstr_import

{
    key FiDocument,
    key FiscalYear,
    FiDocumentItem,      
    DocumentDate,
    TransactionCurrency  ,
    Mironumber,
    MiroYear,
    Refrence_No,
    AccountingDocumentType,
    PostingDate,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    InvoceValue,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    TaxableValue ,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    Gross_amount,
    TaxCode,   
    @Semantics.amount.currencyCode: 'TransactionCurrency'  
    sum(igst)                         as IGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(igst1)                      as IGST1,
    PARTYcODE,
    PlaceofSupply,
    PartyName,
    GstIn,
    State,
    TAXRATE,
    CompanyCode,
    BusinessPlace
    
}

group by   FiDocument,
           FiscalYear,
           FiDocumentItem,         
DocumentDate,           
TransactionCurrency  ,  
Mironumber,             
MiroYear,               
Refrence_No,            
AccountingDocumentType, 
PostingDate,
InvoceValue ,
TaxableValue,
Gross_amount,
TaxCode,
PARTYcODE,                
PlaceofSupply,            
PartyName,                
GstIn,                    
State,                    
TAXRATE ,
CompanyCode,
BusinessPlace                

