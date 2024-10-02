@AbapCatalog.sqlViewName: 'YSUMCONT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Sales Status Price Elements'
define view ZSD_JOB_SALES_CONTRACT_SUM2 as select from ZSD_JOB_SALES_CONTRACT_SUM
{
    key SalesOrder,
       sum(PrPicRate )   as    PrPicRate,
    sum(PrMtrRate)     as   PrMtrRate ,
    sum(MendingCharge)  as  MendingCharge,
    sum(RollingCharge)  as RollingCharge,
    sum(PerPickRate)   as   PerPickRate,
    sum(PerMtrRate)    as  PerMtrRate,
    sum(MendingCharges)   as MendingCharges, 
    sum(RollingCharges) as RollingCharges
}   


group by  
      SalesOrder
