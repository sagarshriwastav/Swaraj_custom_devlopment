@AbapCatalog.sqlViewName: 'YSUBCONTREATC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Stock Subcontractor Report'
define view ZMM_STOCK_SUBCONTRACTOR_CDS as select from I_StockQuantityCurrentValue_2( P_DisplayCurrency:'INR') as a 
 left outer join I_MaterialDocumentItem_2 as b on ( b.Material = a.Product and b.Batch = a.Batch  and b.GoodsMovementType = '541' 
                                                     and b.InventorySpecialStockType = 'F' 
                                                     and b.GoodsMovementIsCancelled = ' '
                                                     and b.SalesOrder = a.SDDocument
                                                     and b.SalesOrderItem = a.SDDocumentItem 
                                                     and b.Supplier = a.Supplier )
   inner join ymseg4 as CNCL on ( CNCL.MaterialDocument = b.MaterialDocument 
                                 and CNCL.MaterialDocumentItem = b.MaterialDocumentItem
                                 and CNCL.MaterialDocumentYear = b.MaterialDocumentYear  )  
   left outer join  I_GoodsMovementCube as CODE on ( CODE.Batch = b.Batch 
                                                and CODE.Material = b.Material
                                                and CODE.MaterialDocument = b.MaterialDocument 
                                                and CODE.MaterialDocumentItem = b.MaterialDocumentItem
                                                and CODE.MaterialDocumentYear = b.MaterialDocumentYear
                                                                                                         )                                                                                 

{ 
    
     key a.Product,
     key a.Plant,
     key a.Batch ,
     key a.Supplier,
         a.ProductGroup,
         a.ProductType,
         a.SDDocument,
         a.SDDocumentItem,
         a.MaterialBaseUnit,
         a.MatlWrhsStkQtyInMatlBaseUnit,
         max( b.MaterialDocument ) as MaterialDocument
   //      b.MaterialDocumentItem as MaterialDocumentItem
      //    case 
     // when  b.MaterialDocumentItem is initial
     // then '000000' 
     // else
     // cast( cast( concat( '00', b.MaterialDocumentItem ) as abap.numc( 6  ) )   
     // as abap.numc( 6  ) ) end as ZMaterialDocumentItem 
      
    //     cast( right( b.MaterialDocumentItem , 4) as abap.numc( 6 ) ) as ZMaterialDocumentItem
}   

  where a.InventorySpecialStockType = 'F' and a.ValuationAreaType = '1'   
   and b.GoodsMovementType = '541' and CODE.GoodsMovementReasonCode = '0000' 
  and a.MatlWrhsStkQtyInMatlBaseUnit > 0
     group by 
         a.Product,
         a.Plant,
         a.Batch ,
         a.Supplier,
         a.ProductGroup,
         a.ProductType,
         a.SDDocument,
         a.SDDocumentItem,
         a.MaterialBaseUnit,
         a.MatlWrhsStkQtyInMatlBaseUnit
   //      b.MaterialDocumentItem
      //   b.PurchaseOrder,
      //   b.PurchaseOrderItem,
     //    b.MaterialDocumentItem
  
