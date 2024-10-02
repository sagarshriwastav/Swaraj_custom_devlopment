@AbapCatalog.sqlViewName: 'YBILLINGSALES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSALES_POLICY_CDS'
define view ZSALES_POLICY_CDS as select from ZSALES_POLICY_CD  as A
left outer join I_BillingDocumentItem as b on ( A.BillingDocument = b.BillingDocument and 
                                               A.plant = b.Plant )
     
    
 {   
    key A.plant,
    key A.policyno,
    key A.BillingDocument,
       cast( 'INR' as abap.cuky( 5 ) ) as TransactionCurrency,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        sum(b.NetAmount) as invoicevalue
       
} group by 
           A.plant,
           A.policyno,
           A.BillingDocument
         
