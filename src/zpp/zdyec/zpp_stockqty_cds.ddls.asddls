@AbapCatalog.sqlViewName: 'YSTOCKQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'QM_INSPECTION REPORT'
define view ZPP_STOCKQTY_CDS as select from I_MaterialStock 

{
   
   key Material ,
   key Plant,
   key Batch,
       MaterialBaseUnit,
       StorageLocation,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( MatlWrhsStkQtyInMatlBaseUnit ) as StockQty   
      
      } 
    where StorageLocation = 'DY01'
   group by 
       Material,
       Plant,
       Batch,
       MaterialBaseUnit,
       StorageLocation
