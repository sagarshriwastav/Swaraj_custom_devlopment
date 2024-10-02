@AbapCatalog.sqlViewName: 'YGSTR1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Gstr1 Report'
define view YGSTR1_BILL_DATA1 as select from ygst_det  as A
inner join I_BillingDocument as B on (B.BillingDocument = A.BillingDocument and B.CompanyCode = A.CompanyCode )
left outer join I_BillingDocument as C on (C.BillingDocument = A.BillingDocument and C.CompanyCode = A.CompanyCode ) 
                                               and ( C.CancelledBillingDocument <> '' or C.BillingDocumentIsCancelled <> '' )
left outer join I_Customer as D on ( D.Customer = A.SoldToParty )
left outer join I_OperationalAcctgDocItem as E on ( E.AccountingDocument = A.AccountingDocument and 
                               E.CompanyCode = A.CompanyCode and E.FinancialAccountType = 'D' and E.FiscalYear  = A.FiscalYear )
left outer join I_ProductPlantBasic as F on ( F.Product = A.Material and F.Plant = A.Plant  )

{ 
 key A.BillingDocument,
 key A.BillingDocumentItem,
 key A.CompanyCode,
     E.BusinessPlace,
     E.AccountingDocumentType,
     E.AccountingDocumentItem as POSTING_VIEW_ITEM,
     A.Plant,
     E.ProfitCenter,     
     A.NetAmount as NetAmount,
     A.TaxAmount as TaxAmount,
     A.TaxCode,
     A.SoldToParty,
     A.AccountingDocument,
     B.BillingDocumentType,
     B.BillingDocumentDate,
     B.Division, 
     B.DistributionChannel,    
     A.BaseUnit,
     A.Material,
     A.FiscalYear,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     A.BillingQuantity   as BillingQuantity,
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
     D.CustomerName as CustomerFullName,
     D.Region,
     D.TaxNumber3,
  //   C.BillingDocumentIsCancelled, 
     case //C.CancelledBillingDocument
     when C.CancelledBillingDocument is not null then 'X'
     else
     C.BillingDocumentIsCancelled end as BillingDocumentIsCancelled,
     C.CancelledBillingDocument , 
     E.PostingDate,
     F.ConsumptionTaxCtrlCode
    
} where (D.TaxNumber3 <> '' and  B.DistributionChannel != '20' )  and A.NetAmount <> 0
 
           
group by  
     A.BillingDocument,
     A.BillingDocumentItem,
     A.NetAmount,
     A.TaxAmount,
     A.CompanyCode,
     A.BillingQuantity,
     E.BusinessPlace,
     E.AccountingDocumentType,
     E.AccountingDocumentItem , 
     A.Plant,
     E.ProfitCenter,
     A.TaxCode,
     A.SoldToParty,
     A.AccountingDocument,
     B.BillingDocumentType,
     B.BillingDocumentDate,
     B.Division,
     B.DistributionChannel,     
     A.BaseUnit,
     A.Material,
     A.TransactionCurrency,        
      A.rATE,
     A.FiscalYear,
     D.CustomerName,
     D.Region,
     D.TaxNumber3,
     C.BillingDocumentIsCancelled,
     C.CancelledBillingDocument,
     E.PostingDate,
     F.ConsumptionTaxCtrlCode
