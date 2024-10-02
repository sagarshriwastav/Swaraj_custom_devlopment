@AbapCatalog.sqlViewName: 'YSUMSTOCKGREY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Module Pool Screen'
define view ZMM_GREY_STOCK_CDS as select from I_MaterialStock_2

{
    key Plant,
    key Material,
    key Batch,
        StorageLocation,
        Supplier,
        MaterialBaseUnit,
        SDDocument,
        SDDocumentItem,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum(MatlWrhsStkQtyInMatlBaseUnit) as Stock
        
}   where InventorySpecialStockType = 'O' or InventorySpecialStockType = 'F'
   group by
        Plant,
        Material,
        Batch,
        Supplier,
        SDDocument,
        SDDocumentItem,
        MaterialBaseUnit,
        StorageLocation
