@AbapCatalog.sqlViewName: 'YEXPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YGSTR1_EXPORT'
define view YGSTR1_NEW_EXPORT as select from I_BillingDocumentItem as A
inner join I_BillingDocument as B on (B.BillingDocument = A.BillingDocument)
left outer join I_BillingDocItemPrcgElmntBasic as C on (C.BillingDocument = A.BillingDocument and C.BillingDocumentItem = A.BillingDocumentItem  )
 and ( C.ConditionType = 'JOIG' or C.ConditionType = 'JOUG' )
left outer join I_ProductPlantBasic as F on ( F.Product = A.Material and F.Plant = A.Plant  )
{
   key A.BillingDocument,
     @Semantics.amount.currencyCode: 'TransactionCurrency' 
     sum(A.NetAmount) as NetAmount,
     A.TaxAmount,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     sum(A.BillingQuantity) as  BillingQuantity, 
     A.TransactionCurrency,  
     A.TaxCode,
     A.SoldToParty,
     A.BaseUnit,
     A.Material,
     A.Plant,
     A.PriceDetnExchangeRate,
     B.FiscalYear,
     B.AccountingDocument,   
     B.BillingDocumentType,
     B.BillingDocumentDate,
     B.Division, 
     B.DistributionChannel, 
     F.ConsumptionTaxCtrlCode,
    C.ConditionType,
    @Semantics.amount.currencyCode: 'TransactionCurrency'  
    case C.ConditionType
    when 'JOIG' then sum(C.ConditionAmount)  end as IGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    case C.ConditionType
    when 'JOUG' then sum(C.ConditionAmount)  end as UGST,
 
    case C.ConditionType
    when 'JOIG' then (C.ConditionRateRatio)   
    when 'JOCG' then (C.ConditionRateRatio) 
    when 'JOSG' then (C.ConditionRateRatio) 
    end as rATE

} where ( B.BillingDocumentType = 'F2' or B.BillingDocumentType = 'CBRE' or B.BillingDocumentType = 'L2' or B.BillingDocumentType = 'G2'  or B.BillingDocumentType = 'S1' )
        and ( B.DistributionChannel = '02')
  group by A.BillingDocument,
    // A.NetAmount,
     A.TaxAmount,
  //   A.BillingQuantity, 
     A.TransactionCurrency,
     C.ConditionType,
     C.ConditionRateRatio,
     A.TaxCode,
     A.SoldToParty,
     A.BaseUnit,
     A.Material,
     A.Plant,
     F.ConsumptionTaxCtrlCode,
     B.AccountingDocument,
     B.BillingDocumentType,
     B.BillingDocumentDate,
     B.Division, 
     B.DistributionChannel, 
     A.PriceDetnExchangeRate,
     B.FiscalYear
