@AbapCatalog.sqlViewName: 'ZPURCHARSEGRNQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase Contract Grn Qty'
define view ZMM_PURCHASE_CONTRACT_GRN_QTY as select from I_PurchaseOrderItemAPI01 as a
                                         left outer join I_MaterialDocumentItem_2 as b on 
                                         ( b.PurchaseOrder = a.PurchaseOrder and b.PurchaseOrderItem = a.PurchaseOrderItem 
                                         and b.GoodsMovementType = '101' and b.GoodsMovementIsCancelled = ' ' )
     
{
    key a.PurchaseContract,
        b.MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum( b.QuantityInEntryUnit ) as Grnqty

}  where a.PurchasingDocumentDeletionCode <> 'L' and b.GoodsMovementType = '101' and b.GoodsMovementIsCancelled = ' '
   group by 
        a.PurchaseContract,
        b.MaterialBaseUnit
