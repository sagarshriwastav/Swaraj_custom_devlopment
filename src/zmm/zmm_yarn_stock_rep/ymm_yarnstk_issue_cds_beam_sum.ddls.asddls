@AbapCatalog.sqlViewName: 'YMMSTOCKSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Stock PrBags and PrCone'
define view YMM_YARNSTK_ISSUE_CDS_BEAM_SUM as select from YMM_YARN_STOCK_ISSUE_CDS_BEAM
{
    key MaterialDocument,
    key MaterialDocumentYear,
    MaterialBaseUnit,
    Batch,
    Plant,  
    StorageLocation,
    ClfnObjectInternalID,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(PrBagKg) as PrBagKg,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(PrConeKg) as PrConeKg
}
   group by
     MaterialDocument,
    MaterialDocumentYear,
    MaterialBaseUnit,
    Batch,
    Plant,
    StorageLocation,
    ClfnObjectInternalID
