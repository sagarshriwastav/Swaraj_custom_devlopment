@AbapCatalog.sqlViewName: 'ZPRICINGCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PRICING CDS'
@Metadata.ignorePropagatedAnnotations: true
define view ZPRICING_CDS as select from I_PurOrdItmPricingElementAPI01 

{ key PurchaseOrder,
  key PurchaseOrderItem,
     ConditionCurrency,
 
// sum( ConditionAmount ) as  ConditionAmount,
 
  @Semantics.amount.currencyCode: 'ConditionCurrency'
 case when ConditionType like 'ZF%'   then  sum( ConditionAmount ) end as  ConditionAmountZF,
 case when ConditionType like 'ZPF%'  then  sum( ConditionAmount ) end as   ConditionAmountZP  ,
 case when ConditionType like 'ZL%'   then  sum( ConditionAmount ) end as   ConditionAmountZL  ,
 case when ConditionType like 'ZI%'   then  sum( ConditionAmount ) end as   ConditionAmountZI  ,
 case when ConditionType like 'ZOT%'  then  sum( ConditionAmount ) end as   ConditionAmountZOT  ,
 case when ConditionType =  'ZMND'    then  sum( ConditionAmount ) end as   ConditionAmount_ZMND  ,
 case when ConditionType =  'ZROL'    then  sum( ConditionAmount ) end as   ConditionAmount_ZROL  ,
 case when ConditionType =  'ZJIL'    then  sum( ConditionAmount ) end as   ConditionAmount_ZJIL  
    

} 
// where  ConditionType = 'ZFA2' or  ConditionType = 'ZFA1' or ConditionType = 'ZFB1' 
//                                 or ConditionType = 'ZFB2' or ConditionType = 'ZFC2' or ConditionType = 'ZFC3'

group by 
 PurchaseOrder,
   PurchaseOrderItem,
    ConditionCurrency,
    ConditionType
