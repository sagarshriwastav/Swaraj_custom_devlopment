@AbapCatalog.sqlViewName: 'YARN543OR541'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Consumption Report MM 1200 Plant'
define view ZMM_YARN_CON_CDS_1200_543_101 
          with parameters   
             @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats 
          as select from I_MaterialDocumentItem_2 as A                                                         
          left outer join zmm_grey_rec_453 as mov543  on ( mov543.setnumber              = A.Batch 
                                                      and mov543.itemcode                = A.Material
                                                      and mov543.matdocument             = A.MaterialDocument 
                                                      and mov543.matdocumentyear         = A.MaterialDocumentYear )  
                                                       
          left outer join zmm_grey_receipt as mov101  on ( mov101.matdocument            = A.MaterialDocument 
                                                      and mov101.matdocumentyear         = A.MaterialDocumentYear
                                                      and mov101.sno                     = mov543.sno 
                                                      and mov101.po                      = A.PurchaseOrder
                                                      and mov101.poitem                  = A.PurchaseOrderItem  )  
                                                       
         left outer join I_MaterialDocumentItem_2 as mov101re  on ( mov101re.Material    = mov101.itemcode 
                                                      and mov101re.Batch                 = mov101.piecenumber
                                                      and mov101re.MaterialDocument      = mov101.matdocument 
                                                      and mov101re.MaterialDocumentYear  = mov101.matdocumentyear
                                                      and mov101re.GoodsMovementType = '101' and mov101re.GoodsMovementIsCancelled = '' ) 
                                                                                                                                                                                                                            
{
    key A.Material,
    key A.Batch,
    key A.Plant,
    key A.PurchaseOrder,
    key A.PurchaseOrderItem,
        A.Supplier,
        mov101re.SalesOrder,
        mov101re.SalesOrderItem,
        mov101.matdocument as MaterialDocument,
        mov101.itemcode,
        mov101.piecenumber,
        mov101.pick,
        mov101.qtylength
  //     cast( mov101re.QuantityInEntryUnit as abap.dec( 13, 3 ) )  as  Dispatc_QTY
        
}
  where    ( A.InventorySpecialStockType = 'O' or A.InventorySpecialStockType = 'F' ) 
           and A.GoodsMovementIsCancelled = '' and A.GoodsMovementType = '543' 
           and A.Material like 'Y%' and mov101.itemcode <> ''
           and A.PostingDate > $parameters.p_posting  and A.PostingDate <= $parameters.p_posting1
   group by
        A.Material,
        A.Batch,
        A.Plant,
        A.PurchaseOrder,
        A.PurchaseOrderItem,
        A.Supplier,
        mov101re.SalesOrder,
        mov101re.SalesOrderItem,
        mov101.matdocument,
        mov101.itemcode,
        mov101.piecenumber,
        mov101.pick,
        mov101.qtylength
 //       mov101re.QuantityInEntryUnit
        
    
     
