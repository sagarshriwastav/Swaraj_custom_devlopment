@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loom Entry Program'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_SUB_CON_LATEST as select from I_MaterialDocumentItem_2 as a 
{
    key max(a.MaterialDocument) as MaterialDocument, 
    key a.MaterialDocumentItem,
    key a.MaterialDocumentYear,
        a.Material,
        a.Plant,
        a.StorageLocation,
        a.Batch
}  
where a.GoodsMovementType = '541' and a.Material like 'BD%'
      and a.Plant = '1200' and a.StorageLocation != ' '
group by
        a.MaterialDocument, 
        a.MaterialDocumentItem,
        a.MaterialDocumentYear,
        a.Material,
        a.Plant,
        a.StorageLocation,
        a.Batch
