@AbapCatalog.sqlViewName: 'YARCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For AR  Report'
define view ZAR_PRINT_FI_CDS as select from I_Customer
{
   key Customer,
   key CustomerName    
} 
 group by 
 Customer,
 CustomerName
