@AbapCatalog.sqlViewName: 'YELEMENT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Pending Report Stock'
define view ZSD_PENDING_ELEMENT_PRIC_1 as select from ZSD_PENDING_ELEMENT_PRIC
{
    key SalesOrder,
    key SalesOrderItem,
  //  ConditionInactiveReason,
    sum(Rate) as Rate,
    sum(CDPercent) as CDPercent
}
 
    group by
    SalesOrder,
    SalesOrderItem
  //  ConditionInactiveReason
