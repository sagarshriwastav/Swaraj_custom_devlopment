@AbapCatalog.sqlViewName: 'YARDIVISION'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For AR Report'
define view ZAR_DIVISION_F4 as select from I_OperationalAcctgDocItem
{
    key DocumentItemText as MatlAccountAssignmentGroup,
        '' as MatlAccountAssignmentGroupName
 
} 
where FinancialAccountType = 'D'
group by 
DocumentItemText
