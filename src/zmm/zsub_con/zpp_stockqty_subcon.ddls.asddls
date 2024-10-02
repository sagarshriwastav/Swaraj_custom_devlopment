@AbapCatalog.sqlViewName: 'YSTOCKQTYSUBCON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Subcon Supplier F4'
define view ZPP_STOCKQTY_SUBCON as select from I_MaterialStock 

{
   
   key Material ,
   key Plant,
   key Batch,
       MaterialBaseUnit,
       StorageLocation,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( MatlWrhsStkQtyInMatlBaseUnit ) as StockQty   
      
   }  where InventorySpecialStockType = 'O' or InventorySpecialStockType = 'F'

   group by 
       Material,
       Plant,
       Batch,
       MaterialBaseUnit,
       StorageLocation
