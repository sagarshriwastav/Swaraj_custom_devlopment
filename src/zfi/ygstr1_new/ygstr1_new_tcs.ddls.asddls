@AbapCatalog.sqlViewName: 'YGSTCS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1_TCS_REPORT'
define view YGSTR1_NEW_TCS as select from I_BillingDocumentItem as A
inner join I_BillingDocument as B on (B.BillingDocument = A.BillingDocument)
inner join I_BillingDocItemPrcgElmntBasic as C on (C.BillingDocument = A.BillingDocument and C.BillingDocumentItem = A.BillingDocumentItem  )
 and ( C.ConditionType = 'JTC1'  )
 // or C.ConditionType = 'JTC1' //or C.ConditionType = 'ZTCS' ) 

{
   key A.BillingDocument,
     A.NetAmount,
     A.TaxAmount,
     A.BaseUnit,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     A.BillingQuantity, 
     A.TransactionCurrency,  
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
    case C.ConditionType
    when 'JTC1' then sum(C.ConditionAmount)  end as TCS

   // when 'ZTCS' then sum(C.ConditionAmount)     end as TCS,


}
    group by A.BillingDocument,
     A.NetAmount,
     A.TaxAmount,
     A.BillingQuantity, 
     A.TransactionCurrency,
     A.BaseUnit,
     C.ConditionType
    
