@AbapCatalog.sqlViewName: 'YJOBSALESPRINT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Sales Order Print'
define view ZSD_JOB_SALES_ORDER_PRINT as select from I_SalesDocument
{
    key  SalesDocument
}  
  group by SalesDocument
