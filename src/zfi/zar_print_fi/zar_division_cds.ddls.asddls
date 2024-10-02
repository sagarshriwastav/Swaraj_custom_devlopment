@AbapCatalog.sqlViewName: 'YDIVISTION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For AR Report'
define view ZAR_DIVISION_CDS as select from I_BillingDocumentItem
{
    key BillingDocument,
        MatlAccountAssignmentGroup
} 
 group by 
 
        BillingDocument,
        MatlAccountAssignmentGroup
