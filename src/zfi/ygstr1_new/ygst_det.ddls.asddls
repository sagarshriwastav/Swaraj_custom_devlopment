@AbapCatalog.sqlViewName: 'YGSDET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'gst_det'
define view ygst_det as select from I_BillingDocumentItem as A 
inner join I_BillingDocumentPartner as Billto  on (Billto.BillingDocument = A.BillingDocument and Billto.PartnerFunction = 'RE' )
inner join I_BillingDocument as B on (B.BillingDocument = A.BillingDocument and B.CompanyCode = A.CompanyCode )
inner join I_BillingDocItemPrcgElmntBasic as C on (C.BillingDocument = A.BillingDocument and C.BillingDocumentItem = A.BillingDocumentItem  
                                                   )
 and ( C.ConditionType = 'JOIG' or C.ConditionType = 'JOCG' or C.ConditionType = 'JOSG' or C.ConditionType = 'JOUG' )
 // or C.ConditionType = 'JTC1' //or C.ConditionType = 'ZTCS' ) 

{
   key A.BillingDocument, 
   key A.BillingDocumentItem,
   key A.CompanyCode,
   key B.FiscalYear,
      A.Plant,
     A.NetAmount,
     A.TaxAmount,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     A.BillingQuantity, 
     A.TransactionCurrency,  
     A.TaxCode,
     Billto.Customer as SoldToParty,
     A.BaseUnit,
     A.Material,
     B.AccountingDocument,
 //  @Semantics.amount.currencyCode: 'TransactionCurrency'  
    C.ConditionType,
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
 //   case C.ConditionType
  //  when 'JTC1' then sum(C.ConditionAmount)  end as TCS,

   // when 'ZTCS' then sum(C.ConditionAmount)     end as TCS,
    
     
    case C.ConditionType
    when 'JOIG' then (C.ConditionRateRatio )   
    when 'JOCG' then (C.ConditionRateRatio * 2 ) 
    when 'JOSG' then (C.ConditionRateRatio * 2 ) 
    end as rATE

}
   where (B.BillingDocumentType = 'F2' or B.BillingDocumentType = 'S1'  or B.BillingDocumentType = 'JSTO') 
    group by A.BillingDocument, 
      A.BillingDocumentItem,
    A.CompanyCode,
     A.NetAmount,
     A.TaxAmount,
     A.BillingQuantity, 
     A.TransactionCurrency,
     C.ConditionType,
     C.ConditionRateRatio,
     A.TaxCode,
     Billto.Customer,
     A.BaseUnit,
     A.Material,
     A.Plant,
     B.FiscalYear,
     B.AccountingDocument
