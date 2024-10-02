@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Revese Job Receipt Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_REVERSE_JOB_RECEIPT as select from I_MaterialDocumentItem_2
{
    key Material,
    key Batch,
    key MaterialDocument,
    key MaterialDocumentItem,
        MaterialDocumentYear,
        GoodsMovementIsCancelled
} 
group by  
        Material,
        Batch,
        MaterialDocument,
        MaterialDocumentItem,
        MaterialDocumentYear,
        GoodsMovementIsCancelled
