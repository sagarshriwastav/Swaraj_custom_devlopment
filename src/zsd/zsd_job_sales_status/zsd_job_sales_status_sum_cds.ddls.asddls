@AbapCatalog.sqlViewName: 'YPRICEAMT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Sales Status Price Elements'
define view ZSD_JOB_SALES_STATUS_SUM_CDS as select from ZSD_JOB_SALES_STATUS_CDS
{
    key SalesOrder,
    key SalesOrderItem,
    sum(PrPicRate )   as    PrPicRate,
    sum(PrMtrRate)     as   PrMtrRate ,
    sum(MendingCharge)  as  MendingCharge,
    sum(RollingCharge)  as RollingCharge
}   


group by  
      SalesOrder,
      SalesOrderItem
