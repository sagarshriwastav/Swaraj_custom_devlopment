@AbapCatalog.sqlViewName: 'YGSTR1BILLDET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BILL_DATA'
define view YGSTR1_BILL_DATA as select distinct from YGSTR1_BILL_DATA1  as A


{ 
 key A.BillingDocument,
 key A.CompanyCode,
     '' as  BillingDocumentItem,
     A.BusinessPlace,
     A.AccountingDocumentType,
     A.POSTING_VIEW_ITEM as POSTING_VIEW_ITEM,
     A.Plant,
     A.ProfitCenter,
     
     sum(A.NetAmount) as NetAmount,
     sum( A.TaxAmount) as TaxAmount,
     A.TaxCode,
     A.SoldToParty,
     A.AccountingDocument,
     A.BillingDocumentType,
     A.BillingDocumentDate,
     A.Division, 
     A.DistributionChannel,    
     A.BaseUnit,
     '' as Material,
     A.FiscalYear,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     sum(A.BillingQuantity)   as BillingQuantity,
   //  A.ConditionType,
     A.TransactionCurrency,   
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(A.IGST) as IGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(A.CGST) as CGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(A.SGST) as SGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(A.UGST) as UGST,
     A.rATE,
     A.CustomerFullName as CustomerFullName,
     A.Region,
     A.TaxNumber3,
     A.BillingDocumentIsCancelled,
     A.CancelledBillingDocument , 
     A.PostingDate,
     A.ConsumptionTaxCtrlCode
    
} //where (D.TaxNumber3 <> '' and  B.DistributionChannel != '20' )  and A.NetAmount <> 0
 
           
group by  A.BillingDocument,
     A.CompanyCode,
 //    A.BillingDocumentItem,
     A.BusinessPlace,
     A.AccountingDocumentType,
     A.POSTING_VIEW_ITEM , 
     A.Plant,
     A.ProfitCenter,    
   //  A.NetAmount,
   //  A.TaxAmount,
     A.TaxCode,
     A.SoldToParty,
     A.AccountingDocument,
     A.BillingDocumentType,
     A.BillingDocumentDate,
     A.Division,
     A.DistributionChannel,     
     A.BaseUnit,
   //  A.Material,
   //  A.BillingQuantity,
     A.TransactionCurrency,        
      A.rATE,
     A.FiscalYear,
     A.CustomerFullName,
     A.Region,
     A.TaxNumber3,
     A.BillingDocumentIsCancelled,
     A.CancelledBillingDocument,
     A.PostingDate,
     A.ConsumptionTaxCtrlCode
