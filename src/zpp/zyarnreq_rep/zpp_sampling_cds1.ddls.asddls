@AbapCatalog.sqlViewName: 'YSMPL4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'FOR QUANTITY SUM'
define view ZPP_SAMPLING_CDS1 as select from I_MaterialStock_2
{
    Material,
    Batch,
    StorageLocation,
    Plant,
    SDDocument,
    SDDocumentItem,
    sum( MatlWrhsStkQtyInMatlBaseUnit) as MatlWrhsStkQtyInMatlBaseUnit
} 
where SDDocument is not initial 

group by
 Material,
    Batch,
    StorageLocation,
    SDDocument,
    SDDocumentItem,
    Plant
    
