@AbapCatalog.sqlViewName: 'YSTOCKQTYTRANFR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Tranfer Posting'
define view ZPP_TRANSFER_POSTING_CDS1 as select from I_MaterialStock 

{
   
   key Material ,
   key Plant,
   key Batch,
       MaterialBaseUnit,
       StorageLocation,
       SDDocument,
       SDDocumentItem,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum( MatlWrhsStkQtyInMatlBaseUnit ) as StockQty   
      
   }  

   group by 
       Material,
       Plant,
       Batch,
       MaterialBaseUnit,
       StorageLocation,
       SDDocument,
       SDDocumentItem
