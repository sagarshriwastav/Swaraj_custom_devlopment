@AbapCatalog.sqlViewName: 'YSALESPOLICYCD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds for billing sales policy'
define view ZSALES_POLICY_CD as select from  zsales_polic_tab  as A
left outer join I_BillingDocumentItem as b on ( A.plant = b.Plant )
     
    
 {   
    key A.plant,
    key A.policyno,
    key b.BillingDocument
} group by 
           A.plant,
           A.policyno,
           b.BillingDocument
         
