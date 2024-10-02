@AbapCatalog.sqlViewName: 'YSDELEMENT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Pending Report Stock'
define view ZSD_PENDING_ELEMENT_PRIC as select from I_SalesOrderItemPricingElement
   
{
    key SalesOrder,
    key SalesOrderItem,
        ConditionInactiveReason,
      case when ConditionType  = 'ZR00' or ConditionType  = 'ZPIK' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as Rate,
      case when ConditionType  = 'ZCHD' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as CDPercent


}  where ConditionInactiveReason != 'X' and ConditionInactiveReason != 'W'
      
