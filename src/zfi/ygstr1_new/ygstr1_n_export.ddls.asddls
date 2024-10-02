@AbapCatalog.sqlViewName: 'YGSTR1EXPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EXPORT_REPORT'
define view YGSTR1_N_EXPORT as select distinct from YGSTR1_NEW2_EXPORT  as A
left outer join I_BillingDocument as C on (C.BillingDocument = A.BillingDocument )and ( C.BillingDocumentIsCancelled <> '' or C.CancelledBillingDocument <> '')
left outer join I_Customer as D on ( D.Customer = A.SoldToParty )
left outer join I_OperationalAcctgDocItem as E on E.AccountingDocument = A.AccountingDocument and E.FinancialAccountType = 'D'  and E.FiscalYear = A.FiscalYear
left outer join YGSTR1_EXPORT_2 as H on ( H.BillingDocument = A.BillingDocument )
{ 
 key A.BillingDocument,
     @Semantics.amount.currencyCode: 'TransactionCurrency' 
     sum(A.NetAmount) as NetAmount,
     A.TaxAmount, 
     A.TaxCode,
     A.SoldToParty,
     A.BillingDocumentType,  
     A.BillingDocumentDate,
     A.Division, 
     A.DistributionChannel,    
     A.BaseUnit,
     A.AccountingDocument,
     A.PriceDetnExchangeRate,
     A.FiscalYear,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     sum(A.BillingQuantity) as BillingQuantity,
     A.TransactionCurrency,     
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(A.IGST) as IGST, 
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(A.UGST) as UGST,     
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     H.FREIGHT_OCEAN as FREIGHT_OCEAN,     
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     H.EXPORT_INS as EXPORT_INS,
     A.rATE,
     D.CustomerName as CustomerFullName,
     E.CompanyCodeCurrency,
     D.Region,
     D.TaxNumber3,
 //    C.BillingDocumentIsCancelled,
     C.CancelledBillingDocument ,    
     E.PostingDate,
     A.ConsumptionTaxCtrlCode,
     E.CompanyCode,
     E.BusinessPlace     as PlaceofSupply,
     E.BusinessPlace     as BusinessPlace,
     case //C.CancelledBillingDocument
      when C.CancelledBillingDocument is not null then 'X'
      else
      C.BillingDocumentIsCancelled end as BillingDocumentIsCancelled
       
} where  A.NetAmount <> 0
group by 
A.BillingDocument,
   //  A.NetAmount,
     A.TaxAmount,
     A.TaxCode,
     A.SoldToParty,
     A.BillingDocumentType,
     A.BillingDocumentDate,
     A.Division, 
     A.DistributionChannel,    
     A.BaseUnit,
     A.AccountingDocument,
     A.PriceDetnExchangeRate,
     A.FiscalYear,
     H.FREIGHT_OCEAN,
     H.EXPORT_INS,
    // A.BillingQuantity,
     A.TransactionCurrency, 
     A.rATE,
     D.CustomerName,
     E.CompanyCodeCurrency,
     D.Region,
     D.TaxNumber3,
     E.PostingDate,
     A.ConsumptionTaxCtrlCode,
     C.BillingDocumentIsCancelled,
     C.CancelledBillingDocument , 
     E.BusinessPlace,
     E.CompanyCode
