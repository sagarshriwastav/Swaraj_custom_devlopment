@AbapCatalog.sqlViewName: 'YSUBCONTRATC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Stock Subcontractor Report'
define view ZMM_STOCK_SUBCONTRACTOR_CDS2 as select from ZMM_STOCK_SUBCONTRACTOR_CDS as a
  left outer join I_MaterialDocumentItem_2 as g on ( g.MaterialDocument = a.MaterialDocument 
                                                and g.Material = a.Product and g.Batch = a.Batch and g.Plant = a.Plant 
                                                and g.GoodsMovementType = '541'  and g.InventorySpecialStockType = 'F' 
                                                and g.SalesOrder = a.SDDocument and g.SalesOrderItem = a.SDDocumentItem ) 
  left outer join ZI_BillingDocumentItem as c on ( c.ReferenceSDDocument = g.MaterialDocument )
                                           //  and c.ReferenceSDDocumentItem = g.MaterialDocumentItem )
  left outer join I_Supplier as d on ( d.Supplier = a.Supplier )    
  left outer join I_ProductDescription as e on ( e.Product = a.Product and e.Language = $session.system_language ) 
  left outer join ZPP_DYEINGR_CDS as f on ( f.Beamno = a.Batch and f.Material = a.Product )  
  left outer join ZPP_YARN_HEAD_TEAST as FF on ( FF.Material = g.Material and FF.Batch = g.Batch )
  
                               
                                              
    
{
     key a.Product,
     key a.Plant,
     key a.Batch ,
         a.Supplier,
         d.SupplierName,
         e.ProductDescription,
         a.ProductGroup,
         a.ProductType,
         a.SDDocument,
         a.SDDocumentItem,
         a.MaterialBaseUnit,
         a.MatlWrhsStkQtyInMatlBaseUnit ,
         max(g.PurchaseOrder) as PurchaseOrder,
         max(g.PurchaseOrderItem) as PurchaseOrderItem,
         a.MaterialDocument,
         c.BillingDocument,
    //     c.BillingDocumentItem,
         c.CreationDate,
         cast( 'KG' as abap.unit( 3 ) ) as zunit,
         @Semantics.quantity.unitOfMeasure: 'zunit'
         f.Grossweight ,
         @Semantics.quantity.unitOfMeasure: 'zunit'
         f.Netweight,
         f.Greyshort,
         g.StorageLocation,
         FF.Lotnumber,
         FF.ActualCount
    //     a.MaterialDocumentItem

} //      where  a.Product like 'ZYRP'

group by a.Product,
          a.Plant,
          a.Batch,
          a.Supplier,
          d.SupplierName,
          e.ProductDescription,
          a.ProductGroup,
          a.ProductType,
          a.SDDocument,
          a.SDDocumentItem,
          a.MaterialBaseUnit,
          g.PurchaseOrder,
          g.PurchaseOrderItem,
          a.MaterialDocument,
          a.MatlWrhsStkQtyInMatlBaseUnit,
          c.BillingDocument,
        //  c.BillingDocumentItem,
          c.CreationDate,
          f.Grossweight,
          f.Netweight,
          f.Greyshort,
          g.StorageLocation,
          FF.Lotnumber,
          FF.ActualCount
  //        a.MaterialDocumentItem
          
