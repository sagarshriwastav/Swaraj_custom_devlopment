@AbapCatalog.sqlViewName: 'YBEAMLENGHT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Shrinkage Loom Entry Beam Lenght'
define view ZPP_SHRINKAGE_LOOM_BEAMLEN_101 as select from I_MaterialDocumentItem_2 as a
    left outer join I_Supplier as b on ( b.Supplier = a.Supplier )
{
    key a.Batch,
    key substring(a.Supplier,4,7) as Supplier,
        a.QuantityInEntryUnit as Beamlength,
        b.SupplierName ,
        a.PurchaseOrder,
        a.PurchaseOrderItem
    
} 
  
   where  a.Material like 'BD%' and a.GoodsMovementType = '541' 
         //  a.GoodsMovementType = '101' 
     //   and a.InventorySpecialStockType = 'F'
          and a.GoodsMovementIsCancelled = ''
          group by 
          a.Batch,
          a.Supplier,
          b.SupplierName,
          QuantityInEntryUnit,
           a.PurchaseOrder,
        a.PurchaseOrderItem
         
