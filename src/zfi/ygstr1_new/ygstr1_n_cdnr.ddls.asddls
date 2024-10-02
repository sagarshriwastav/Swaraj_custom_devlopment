@AbapCatalog.sqlViewName: 'YGSTR1CDNR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YGSTR1_N_CDS'
define view YGSTR1_N_CDNR as select distinct from YGSTR1_CDNR_NEW1  as A
{ 
 key A.BillingDocument,
 key A.CompanyCode,
     A.Plant,
     sum(A.NetAmount) as NetAmount,
     sum( A.TaxAmount) as TaxAmount,
     A.TaxCode,
     A.SoldToParty,
     A.BillingDocumentType,
     A.BillingDocumentDate,
     A.Division,
     A.DistributionChannel,
     A.BaseUnit,
     '' as Material,
     sum(A.BillingQuantity)   as BillingQuantity,
    // A.ConditionType,
     A.AccountingDocument,
  //   A.PostingDate,
     A.TransactionCurrency, 
     A.FiscalYear,  
     A.BusinessPlace,
     A.AccountingDocumentType,
     A.POSTING_VIEW_ITEM as POSTING_VIEW_ITEM,
     A.ProfitCenter,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(A.IGST) as IGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
    sum( A.CGST )  as  CGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
    sum( A.SGST )  as  SGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'  
     A.UGST,
   //  A.TCS,     
     A.rATE,
     A.CustomerFullName as CustomerFullName,
     A.Region,
     A.TaxNumber3,
 //    C.BillingDocumentIsCancelled,
     case //C.CancelledBillingDocument
     when A.CancelledBillingDocument is not null then 'X'
     else
     A.BillingDocumentIsCancelled end as BillingDocumentIsCancelled,
     A.CancelledBillingDocument,
     A.PostingDate,
     A.ConsumptionTaxCtrlCode
    
       
} 

          group by
          
     A.BillingDocument,
 //    A.NetAmount,
 //    A.TaxAmount,
     A.TaxCode,
     A.SoldToParty,
     A.BillingDocumentType,
     A.BillingDocumentDate,
     A.Division,
     A.DistributionChannel,
     A.BaseUnit,
   //  A.Material,
     A.CompanyCode,
     A.Plant,
     // A.BillingQuantity,
     A.AccountingDocument,
     A.TransactionCurrency,
     A.FiscalYear,
     A.UGST,   
     A.rATE,
     A.CustomerFullName,
     A.Region,
     A.TaxNumber3,
     A.BillingDocumentIsCancelled,
     A.CancelledBillingDocument,
     A.PostingDate,
     A.ConsumptionTaxCtrlCode,
     A.BusinessPlace,
     A.AccountingDocumentType,
     A.POSTING_VIEW_ITEM,
     A.ProfitCenter
