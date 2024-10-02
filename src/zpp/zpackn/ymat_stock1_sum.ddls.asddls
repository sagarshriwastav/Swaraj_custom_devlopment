@AbapCatalog.sqlViewName: 'YSUMSTOCKDENIM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mat_Stock'
define view Ymat_STOCK1_SUM as select from I_MaterialStock as a
{
    key a.Material,
  key a.Plant,
  key a.StorageLocation,
  key a.Batch,
  key a.SDDocument,
  key a.SDDocumentItem,
      a.MaterialBaseUnit,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     sum( a.MatlWrhsStkQtyInMatlBaseUnit ) as  MatlWrhsStkQtyInMatlBaseUnit 
}  
   
group by 
   a.Material,
   a.Plant,
   a.StorageLocation,
   a.Batch,
   a.SDDocument,
   a.SDDocumentItem, 
   a.MaterialBaseUnit