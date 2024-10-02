@AbapCatalog.sqlViewName: 'YGSCDNR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDNR_REPORT'
define view YGSTR1_CDNR_NEW as select from I_BillingDocumentItem as A
inner join I_BillingDocument as B on (B.BillingDocument = A.BillingDocument and B.CompanyCode = A.CompanyCode )
inner join I_BillingDocItemPrcgElmntBasic as C on (C.BillingDocument = A.BillingDocument and C.BillingDocumentItem = A.BillingDocumentItem  )
 and ( C.ConditionType = 'JOIG' or C.ConditionType = 'JOCG' or C.ConditionType = 'JOSG' or C.ConditionType = 'JOUG' )
  //or C.ConditionType = 'JTC1' //or C.ConditionType = 'ZTCS' ) 
{
   key A.BillingDocument, 
   key A.BillingDocumentItem,
   key A.CompanyCode,
     A.NetAmount,
     A.TaxAmount,
     A.BillingQuantity, 
     A.TransactionCurrency,  
     A.TaxCode,
     A.SoldToParty,
     A.BaseUnit,
     A.Material,
     A.Plant,
  // @Semantics.amount.currencyCode: 'TransactionCurrency'  
    C.ConditionType,
    B.AccountingDocument,
    B.FiscalYear,
   // d.PostingDate,
    case C.ConditionType
    when 'JOIG' then sum(C.ConditionAmount)  end as IGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    case C.ConditionType
    when 'JOCG' then sum(C.ConditionAmount)  end as CGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    case C.ConditionType
    when 'JOSG' then sum(C.ConditionAmount)  end as SGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    case C.ConditionType
    when 'JOUG' then sum(C.ConditionAmount)  end as UGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
  //  case C.ConditionType
   // when 'JTC1' then sum(C.ConditionAmount)  end as TCS,

   // when 'ZTCS' then sum(C.ConditionAmount)     end as TCS,
    
     
    case C.ConditionType
    when 'JOIG' then (C.ConditionRateRatio)   
    when 'JOCG' then (C.ConditionRateRatio * 2 ) 
    when 'JOSG' then (C.ConditionRateRatio * 2 ) 
    end as rATE

} where  B.BillingDocumentType = 'CBRE' or B.BillingDocumentType = 'L2' or B.BillingDocumentType = 'G2' or B.BillingDocumentType = 'S2' 
  group by A.BillingDocument,
     A.NetAmount,
     A.TaxAmount,
     A.CompanyCode,
     A.BillingQuantity, 
     A.TransactionCurrency,
     C.ConditionType,
     B.AccountingDocument,
     B.FiscalYear,
    // d.PostingDate,
     C.ConditionRateRatio,
     A.BillingDocumentItem,
     A.TaxCode,
     A.SoldToParty,
     A.BaseUnit,
     A.Material,
     A.Plant
