@AbapCatalog.sqlViewName: 'YPURCON2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase Contract Condition Amount'
define view ZMM_PURCHASE_CONTRACT_CON_AMT2 as select from ZMM_PURCHASE_CONTRACT_CON_AMT  as a
   left outer join I_PurOrdItmPricingElementAPI01 as b on (b.PurchaseOrder = a.PurchaseOrder 
                                                           and b.PurchaseOrderItem = a.PurchaseOrderItem )
{
       key a.PurchaseContract,
       case when b.ConditionType = 'ZP01' then b.ConditionRateValue else 0 end as PerPickRate,
       case when b.ConditionType = 'ZROL' then b.ConditionRateValue else 0 end as RollingCharges,
       case when b.ConditionType = 'ZMND' then b.ConditionRateValue else 0 end as MendingCharges,
       case when b.ConditionType = 'ZJIL' then b.ConditionRateValue else 0 end as JiletinCharges


}  
where    ( b.ConditionType = 'ZP01' or b.ConditionType = 'ZROL'
        or b.ConditionType = 'ZMND' or b.ConditionType = 'ZJIL' ) 
