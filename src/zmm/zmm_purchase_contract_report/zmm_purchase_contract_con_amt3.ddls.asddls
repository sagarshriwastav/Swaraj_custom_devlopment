@AbapCatalog.sqlViewName: 'YSUMCONTR3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase Contract Condition Amount'
define view ZMM_PURCHASE_CONTRACT_CON_AMT3 as select from ZMM_PURCHASE_CONTRACT_CON_AMT2
{
    key PurchaseContract,
    sum(PerPickRate) as PerPickRate,
    sum(RollingCharges) as RollingCharges,
    sum(MendingCharges) as MendingCharges,
    sum(JiletinCharges) as JiletinCharges

} 
  group by 
     PurchaseContract
