@AbapCatalog.sqlViewName: 'YBMSTOCK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Beam Stock Report'
define view ZPP_BM_STOCK as select from I_StockQuantityCurrentValue_2(P_DisplayCurrency : 'INR' ) as a
{
    key a.Product,
    key a.Plant,
    key a.StorageLocation,
    key a.Batch,
        a.MaterialBaseUnit,
        a.SDDocument,
        a.SDDocumentItem,
        a.Supplier,
        a.InventorySpecialStockType,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum(a.MatlWrhsStkQtyInMatlBaseUnit) as CurrentStock
}  
    where a.InventoryStockType = '01' and ( a.Product like 'BD%' or a.Product like 'Y%' ) and a.ValuationAreaType = '1'
      group by 
             a.Product,
             a.Plant,
             a.StorageLocation,
             a.Batch,
             a.MaterialBaseUnit,
             a.SDDocument,
             a.SDDocumentItem ,
             a.Supplier,
             a.InventorySpecialStockType   
