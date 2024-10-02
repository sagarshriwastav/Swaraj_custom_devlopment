@AbapCatalog.sqlViewName: 'YDYED'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyed Beam Dispatch Subcon Module Pool Screen'
define view ZMM_DYED_DISPATCH as select from I_POSubcontractingCompAPI01 as a
      inner join I_StockQuantityCurrentValue_2(P_DisplayCurrency : 'INR' )  as b on ( b.Product = a.Material )
      inner join I_ProductDescription as c on ( c.Product = a.Material and c.Language = 'E' )
      left outer join I_PurchaseOrderItemAPI01 as d on (d.PurchaseOrder = a.PurchaseOrder and d.PurchaseOrderItem = a.PurchaseOrderItem )
     left outer join  I_PurchaseOrderAPI01 as e on  ( e.PurchaseOrder = a.PurchaseOrder )
     left outer join I_Supplier as f on ( f.Supplier = e.Supplier ) 
     left outer join ZPP_DYEINGR_CDS as g on ( g.Material = a.Material and g.Beamno = b.Batch ) 
     left outer join ZMM_GREY_RECEIPT_Target_QTY as h on ( h.PurchaseOrder = a.PurchaseOrder and h.PurchaseOrderItem = a.PurchaseOrderItem )
{
    key a.Material ,
    key a.PurchaseOrder,
    key a.PurchaseOrderItem,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
       cast( ( case when a.RequiredQuantity is not initial then a.RequiredQuantity else 0 end ) as abap.dec( 13, 3 ) )
        - cast( ( case when  h.Qty is not initial then h.Qty else 0 end ) as abap.dec( 13, 3 ) ) as RequiredQuantity,
        a.Plant,
        b.Batch ,
        b.MaterialBaseUnit,    
        b.StorageLocation,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        b.MatlWrhsStkQtyInMatlBaseUnit,
        b.SDDocument,
        b.SDDocumentItem,
        c.ProductDescription,
        d.Material as GreyFebric,
        g.Pipenumber as PartyBeam,
        e.Supplier ,
        f.SupplierName
    
}   

   where b.StorageLocation = 'DY01' and a.Plant = '1200' and   b.MatlWrhsStkQtyInMatlBaseUnit > 0 and b.ValuationAreaType = '1'

