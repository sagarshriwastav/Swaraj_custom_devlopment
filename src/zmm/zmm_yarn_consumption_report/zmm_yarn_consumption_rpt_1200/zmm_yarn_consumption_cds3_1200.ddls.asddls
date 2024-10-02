@AbapCatalog.sqlViewName: 'YARNCON31200'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Consumption Report'
define view ZMM_YARN_CONSUMPTION_CDS3_1200 with parameters 
             @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
  as select from ZMM_YARN_CONSUMPTION_CDS2_1200 (p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 ) as a
      
  left outer join ZMM_YARN_CON_CDS_1200_543_101 (p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 ) as mov54101 
                                                                 on ( mov54101.Material =  a.Material and mov54101.Batch = a.Batch 
                                                                 and mov54101.Plant = a.Plant and mov54101.PurchaseOrder = a.PurchaseOrder 
                                                                 and mov54101.PurchaseOrderItem = a.PurchaseOrderItem 
                                                                 and mov54101.Supplier = a.Supplier541 )
   
   left outer join I_PurchaseOrderItemAPI01 as J on ( J.PurchaseOrder = a.PurchaseOrder and J.PurchaseOrderItem = a.PurchaseOrderItem )                                                               
  
   left outer join I_MaterialDocumentItem_2  as b on (b.Material = mov54101.itemcode and b.Batch = mov54101.piecenumber and b.Plant = mov54101.Plant 
                                                  and b.GoodsMovementType = '101'  and b.GoodsMovementIsCancelled = ''
                                                   and b.MaterialDocument = mov54101.MaterialDocument 
                                                   and b.Supplier = mov54101.Supplier 
                                                    and b.PurchaseOrder = mov54101.PurchaseOrder 
                                                   and b.PurchaseOrderItem = mov54101.PurchaseOrderItem )
                                            
{
    key a.Material,
    key a.Batch,
    key a.Plant,
    a.PurchaseOrder,
    a.PurchaseOrderItem,
    a.YARNRECEIVED as YARNRECEIVED,
    a.YARNRETURN as YARNRETURN,
    sum(b.QuantityInEntryUnit) as Dispatch_Qty,
    a.ProductDescription,
    a.MaterialBaseUnit,
    a.Supplier,
    a.ReferenceDocument,
    mov54101.itemcode as FabricMaterial,
    sum(mov54101.qtylength) as qtylength,
    J.YY1_ReedSpaceFor_Po_PDI
    

}
   group by
    a.Material,
    a.Batch,
    a.Plant,
    a.PurchaseOrder,
    a.PurchaseOrderItem,
    a.YARNRECEIVED,
    a.YARNRETURN,
    a.MaterialBaseUnit,
    mov54101.itemcode,
    a.Supplier,
    a.ReferenceDocument,
    a.ProductDescription,
  //  mov54101.qtylength,
    J.YY1_ReedSpaceFor_Po_PDI
