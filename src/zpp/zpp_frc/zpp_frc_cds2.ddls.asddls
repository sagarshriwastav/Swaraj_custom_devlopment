@AbapCatalog.sqlViewName: 'YSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Stock Subcontractor Report'
define view ZPP_FRC_CDS2 as select from ZPP_FRC_CDS as a 
   left outer join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
{
    key a.Material,
    key a.Plant,
    key a.Batch,
    a.StorageLocation,
    a.SDDocument,
    a.SDDocumentItem,
    a.MaterialBaseUnit, 
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    a.MatlWrhsStkQtyInMatlBaseUnit,
    b.ProductDescription
}  
 where  a.MatlWrhsStkQtyInMatlBaseUnit > 0 
