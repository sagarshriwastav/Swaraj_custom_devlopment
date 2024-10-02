@AbapCatalog.sqlViewName: 'YCONTRACTSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Sales Status Price Elements'
define view ZSD_JOB_SALES_CONTRACT_SUM as select from  I_SalesDocItemPricingElement
   
{
    key SalesDocument as SalesOrder,
      case when ConditionType  = 'ZPIK' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as PrPicRate,
      case when ConditionType  = 'ZPIC' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as PrMtrRate,
          case when ConditionType  = 'ZMND' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as MendingCharge,
          case when ConditionType  = 'ZROL' and ConditionRateValue is not initial 
      then cast( ConditionRateValue as abap.dec( 13, 2 ) ) else 0 end as RollingCharge,
      case when ConditionType  = 'ZPIK' and ConditionAmount is not initial 
      then cast( ConditionAmount as abap.dec( 13, 2 ) ) else 0 end as PerPickRate,
      case when ConditionType  = 'ZPIC' and ConditionAmount is not initial 
      then cast( ConditionAmount as abap.dec( 13, 2 ) ) else 0 end as PerMtrRate,
          case when ConditionType  = 'ZMND' and ConditionAmount is not initial 
      then cast( ConditionAmount as abap.dec( 13, 2 ) ) else 0 end as MendingCharges,
          case when ConditionType  = 'ZROL' and ConditionAmount is not initial 
      then cast( ConditionAmount as abap.dec( 13, 2 ) ) else 0 end as RollingCharges


}  // where ConditionInactiveReason != 'X' and ConditionInactiveReason != 'W'
      
