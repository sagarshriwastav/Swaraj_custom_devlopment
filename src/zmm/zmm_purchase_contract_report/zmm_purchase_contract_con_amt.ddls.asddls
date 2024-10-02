@AbapCatalog.sqlViewName: 'YPURCONAMT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase Contract Condition Amount'
define view ZMM_PURCHASE_CONTRACT_CON_AMT as select from I_PurchaseContractItemAPI01 as a
  left outer join  I_PurchaseContractHistoryAPI01 as b on ( b.PurchaseContract = a.PurchaseContract 
                                                        and b.PurchaseContractItem = a.PurchaseContractItem )
{
    key a.PurchaseContract,
    min(b.ReleaseOrder) as PurchaseOrder,
    min(b.ReleaseOrderItem ) as PurchaseOrderItem

}   where 
         a.PurchasingContractDeletionCode <> 'L'  and a.PurchaseContractItem <> '00010' 
         group by 
         a.PurchaseContract
