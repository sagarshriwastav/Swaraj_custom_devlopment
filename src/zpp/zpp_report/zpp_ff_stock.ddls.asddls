@AbapCatalog.sqlViewName: 'YFFSTOCK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Finish Fabric Stock Report'
define view ZPP_FF_STOCK as select from I_StockQuantityCurrentValue_2(P_DisplayCurrency : 'INR' ) as a
{
    key a.Product,
    key a.Plant,
    key a.StorageLocation,
    key a.Batch,
        a.MaterialBaseUnit,
        a.SDDocument,
        a.SDDocumentItem,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum(a.MatlWrhsStkQtyInMatlBaseUnit) as CurrentStock
}  
    where a.ValuationAreaType = '1' and ( a.Product like 'FF%'  or a.Product like 'W%' or a.Product like '00%' )
      group by 
             a.Product,
             a.Plant,
             a.StorageLocation,
             a.Batch,
             a.MaterialBaseUnit,
             a.SDDocument,
             a.SDDocumentItem    
