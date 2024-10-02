@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'QTY SUM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_MIGO_QTY_SUM as select from I_MaterialDocumentItem_2 as  A
//inner  join zmm_grey_receipt as b on ( A.PurchaseOrder = b.po )// and b.setnumber = A.Batch  )
{
 key A.PurchaseOrder,
   //  b.setnumber,
    // A.PurchaseOrderItem,
    
     A.MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     sum(A.QuantityInBaseUnit )   as qty_migo
    
} where A.GoodsMovementType = '101'  and A.GoodsMovementIsCancelled = ''
 
 group by 
           A.PurchaseOrder,
           // b.setnumber,
          //  A.QuantityInBaseUnit,
             A.MaterialBaseUnit
            
       // A.PurchaseOrderItem
