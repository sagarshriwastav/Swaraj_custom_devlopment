@AbapCatalog.sqlViewName: 'YSDPRICEELEMENT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Sales Status Price Elements'
define view ZSD_JOB_SALES_STATUS_CDS as select from I_SalesDocItemPricingElement
   
{
    key SalesDocument as SalesOrder,
    key SalesDocumentItem  as SalesOrderItem,
      case when ConditionType  = 'ZPIK' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as PrPicRate,
      case when ConditionType  = 'ZPIC' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as PrMtrRate,
          case when ConditionType  = 'ZMND' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as MendingCharge,
          case when ConditionType  = 'ZROL' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as RollingCharge


}  // where ConditionInactiveReason != 'X' and ConditionInactiveReason != 'W'
      
