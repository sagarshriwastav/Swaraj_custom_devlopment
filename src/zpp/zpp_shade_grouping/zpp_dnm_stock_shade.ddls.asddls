@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Denim Shade CDS STOCK SHADE'
define root view entity ZPP_DNM_STOCK_SHADE as select from I_MaterialStock_2

{
    
 key Plant,
 key Material,
 key Batch,
    MaterialBaseUnit,
    StorageLocation,
    SDDocument,
    SDDocumentItem,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum( MatlWrhsStkQtyInMatlBaseUnit ) as StockQty 
 
} group by Plant,
           Material,
           Batch,
           MaterialBaseUnit,
           SDDocument,
           SDDocumentItem,
           StorageLocation
