@AbapCatalog.sqlViewName: 'YSUMSTOCKSUM3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Finishing Entry Sum Stock'
define view ZPP_FINISH_ENTRY_STOCK2 as select from ZPP_FINISH_ENTRY_STOCK

{
    key Material,
    key Plant,
    key StorageLocation,
    key Batch,
    MaterialBaseUnit,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum( Stock ) as  Stock
} where   Stock > 0 
    group by  
       Material,
       Plant,
       StorageLocation,
       Batch,
       MaterialBaseUnit
   
