@AbapCatalog.sqlViewName: 'YGSTR1B2CL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'B2CL_GSTR1_REPORT'
define view YGSTR1_N_B2CL as select distinct from ygst_det  as A
inner join I_BillingDocument as B on (B.BillingDocument = A.BillingDocument and B.CompanyCode = A.CompanyCode and B.FiscalYear = A.FiscalYear 
                                      )
left outer join I_BillingDocument as C on (C.BillingDocument = A.BillingDocument  and 
                                     C.CompanyCode = A.CompanyCode and C.FiscalYear = A.FiscalYear ) and 
                                     ( C.CancelledBillingDocument <> '' or C.BillingDocumentIsCancelled <> ''  )
left outer join I_Customer as D on ( D.Customer = A.SoldToParty )
left outer join I_OperationalAcctgDocItem as E on E.AccountingDocument = A.AccountingDocument and E.FinancialAccountType = 'D' 
                                                 and E.FiscalYear = A.FiscalYear and E.CompanyCode = A.CompanyCode 
left outer join I_ProductPlantBasic as F on ( F.Product = A.Material and F.Plant = A.Plant )
{ 
 key A.BillingDocument,
 key A.CompanyCode,
 key A.FiscalYear,
 key A.Plant,
     A.NetAmount,
     A.TaxAmount,
     A.TaxCode,
     A.SoldToParty,
     B.BillingDocumentType,
     B.BillingDocumentDate,
     B.Division,
     B.DistributionChannel,
     A.BaseUnit,
     A.Material,
     A.BillingQuantity,
     A.TransactionCurrency, 
     A.AccountingDocument,
     E.BusinessPlace,
     E.AccountingDocumentType,
     E.AccountingDocumentItem as POSTING_VIEW_ITEM,
     E.ProfitCenter,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(A.IGST) as IGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
    sum( A.CGST )   as CGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum( A.SGST )  as SGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(A.UGST) as UGST,
   //  A.TCS,
     A.rATE,
     D.CustomerName as CustomerFullName,
     D.Region,
     D.TaxNumber3,
    // C.BillingDocumentIsCancelled,
     case //C.CancelledBillingDocument
     when C.CancelledBillingDocument is not null then 'X'
     else
     C.BillingDocumentIsCancelled end as BillingDocumentIsCancelled,
     C.CancelledBillingDocument,
     E.PostingDate,
     F.ConsumptionTaxCtrlCode
    
       
} where (D.TaxNumber3 = ''  and B.DistributionChannel != '02') 
           
  group by 
     A.BillingDocument, 
     A.CompanyCode,
     A.Plant,
     A.NetAmount,
     A.TaxAmount,
     A.TaxCode,
     A.SoldToParty,
     B.BillingDocumentType,
     B.BillingDocumentDate,
     B.Division,
     B.DistributionChannel,
     A.BaseUnit,
     A.Material,
     A.BillingQuantity,
     A.TransactionCurrency, 
     A.AccountingDocument,
     A.FiscalYear,
     E.BusinessPlace,
     E.AccountingDocumentType,
     E.AccountingDocumentItem,
     E.ProfitCenter,
     A.rATE,
     D.CustomerName,
     D.Region,
     D.TaxNumber3,
     C.BillingDocumentIsCancelled,
     C.CancelledBillingDocument,
     E.PostingDate,
     F.ConsumptionTaxCtrlCode
    
           
