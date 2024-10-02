@AbapCatalog.sqlViewName: 'YSALESPOLICY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds for sales policy head'
define view ZSALES_POLICY_HEAD_CDS1 as select from ZSALES_POLICY_CDS 
    
{
     
       key plant,
       key BillingDocument as invoice,
       cast('INR' as abap.cuky( 5 ) ) as  TransactionCurrency,
           @Semantics.amount.currencyCode: 'TransactionCurrency'
          invoicevalue  as invoicevalue
       
}//group by plant,
//          BillingDocument
     
