@AbapCatalog.sqlViewName: 'YSUMJOB'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Receipt Register Report'
define view ZMM_JOB_REC_REG_CDS_SUM as select from ZMM_JOB_REC_REG_CDS_SUM1
{
    key MaterialDocument,
    key MaterialDocumentYear,
    Material,
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
    Material,
    MaterialBaseUnit,
    Batch,
    Plant,
    StorageLocation,
    ClfnObjectInternalID
