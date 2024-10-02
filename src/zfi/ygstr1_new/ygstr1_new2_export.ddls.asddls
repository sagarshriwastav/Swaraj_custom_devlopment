@AbapCatalog.sqlViewName: 'YEXPORTNEW2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1'
define view YGSTR1_NEW2_EXPORT as select from YGSTR1_NEW_EXPORT as a 
{ 
 key a.BillingDocument,
      @Semantics.amount.currencyCode: 'TransactionCurrency' 
     sum(a.NetAmount) as  NetAmount,
     a.TaxAmount,
     a.TaxCode,
     a.SoldToParty,
     a.AccountingDocument,
     a.BillingDocumentType,
     a.BillingDocumentDate,
     a.Division, 
     a.DistributionChannel,    
     a.BaseUnit,
     a.Plant,
     a.PriceDetnExchangeRate,
     a.FiscalYear,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     sum(a.BillingQuantity)  as BillingQuantity,
     a.ConsumptionTaxCtrlCode,
     a.TransactionCurrency,   
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(a.IGST) as IGST,
     @Semantics.amount.currencyCode: 'TransactionCurrency'  
     sum(a.UGST) as UGST,
     a.rATE

}
           
group by  
     a.BillingDocument,
     a.TaxAmount,
     a.TaxCode,
     a.SoldToParty,
     a.AccountingDocument,
     a.BillingDocumentType,
     a.BillingDocumentDate,
     a.Division,
     a.DistributionChannel,     
     a.BaseUnit,
     a.TransactionCurrency,        
     a.rATE,
     a.Plant,
     a.ConsumptionTaxCtrlCode,
     a.PriceDetnExchangeRate,
     a.FiscalYear
 
