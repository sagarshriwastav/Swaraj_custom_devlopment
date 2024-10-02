@AbapCatalog.sqlViewName: 'YGSTRECON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gst Recon'
define view YGSTR1_BILL_DATA_GST_RECON as select from YGSTR1_BILL_DATA
{
    key BillingDocument,
    key CompanyCode,
    BillingDocumentItem,
    BusinessPlace,
    AccountingDocumentType,
    POSTING_VIEW_ITEM,
    Plant,
    ProfitCenter,
    '' as ConsumptionTaxCtrlCode,
   sum(NetAmount) as NetAmount,
     sum( TaxAmount) as TaxAmount,
    TaxCode,
    SoldToParty,
    AccountingDocument,
    BillingDocumentType,
    BillingDocumentDate,
    Division,
    DistributionChannel,
    Material,
    FiscalYear,
    sum(BillingQuantity)   as BillingQuantity,
   //  A.ConditionType,
     TransactionCurrency,   
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(IGST) as IGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(CGST) as CGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(SGST) as SGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(UGST) as UGST,
    rATE,
    CustomerFullName,
    Region,
    TaxNumber3,
    BillingDocumentIsCancelled,
    CancelledBillingDocument,
    PostingDate
} 
   group by
    BillingDocument,
    CompanyCode,
    BillingDocumentItem,
    BusinessPlace,
    AccountingDocumentType,
    POSTING_VIEW_ITEM,
    Plant,
    ProfitCenter,
    TaxCode,
    SoldToParty,
    AccountingDocument,
    BillingDocumentType,
    BillingDocumentDate,
    Division,
    DistributionChannel,
    Material,
    FiscalYear,
    TransactionCurrency,
    rATE,
    CustomerFullName,
    Region,
    TaxNumber3,
    BillingDocumentIsCancelled,
    CancelledBillingDocument,
    PostingDate
