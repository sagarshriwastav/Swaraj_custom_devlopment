@AbapCatalog.sqlViewName: 'YSUMDENIMJOB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Mat_Stock'
define view Ymat_STOCK1_SUM2_job as select from Ymat_STOCK1_SUM_JOB as a
{
    key Material,
    key Plant,
    key StorageLocation,
    key Batch,
    key SDDocument,
    key SDDocumentItem,
    MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum( MatlWrhsStkQtyInMatlBaseUnit ) as STock
 
 }    where MatlWrhsStkQtyInMatlBaseUnit > 0
   
   group by 
   a.Material,
   a.Plant,
   a.StorageLocation,
   a.Batch,
   a.SDDocument,
   a.SDDocumentItem, 
   a.MaterialBaseUnit
