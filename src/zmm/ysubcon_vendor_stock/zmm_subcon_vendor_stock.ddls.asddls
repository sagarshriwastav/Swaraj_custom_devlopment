@AbapCatalog.sqlViewName: 'YMMSTOCKSUBCON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Subcon Vendor  Stock Report'
define view ZMM_SUBCON_VENDOR_STOCK as select from I_StockQuantityCurrentValue_2 (P_DisplayCurrency : 'INR' )

{
    key Product,
    key Plant,
    key Batch,
        StorageLocation,
        MaterialBaseUnit,
        Supplier,
        SDDocument,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum(MatlWrhsStkQtyInMatlBaseUnit) as  STOCK
}  
  where ( InventoryStockType = 'O' or InventoryStockType = 'F' ) and MatlWrhsStkQtyInMatlBaseUnit > 0
  
   group by 
        Product,
        Plant,
        Batch,
        StorageLocation,
        MaterialBaseUnit,
        Supplier,
        SDDocument
