@AbapCatalog.sqlViewName: 'YSUMSTOCKFRC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Frc Report Stock Quantity Sum'
define view ZPP_STOCK_QUANTITY_SUM as select from I_MaterialStock_2
{
     key Material ,
     key Batch,
     key StorageLocation,
     key Plant,
         sum(MatlWrhsStkQtyInMatlBaseUnit ) as StcoKQuantity
 
 }
 group by 
       Material ,
       Batch,
       StorageLocation,
       Plant
