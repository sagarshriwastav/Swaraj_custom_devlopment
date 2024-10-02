@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'date cds'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zmage_order_dt_cds as select from I_MaterialDocumentItem_2
{
  key I_MaterialDocumentItem_2.Plant as plant,
  key I_MaterialDocumentItem_2.Material as material,
  key I_MaterialDocumentItem_2.StorageLocation as StorageLocation,
  key I_MaterialDocumentItem_2.MaterialBaseUnit as MaterialBaseUnit,
  key I_MaterialDocumentItem_2.Batch as BATCH,
  min (I_MaterialDocumentItem_2.PostingDate) as POSTINGDATE
} group by
          I_MaterialDocumentItem_2.Plant,
          I_MaterialDocumentItem_2.Material,
          I_MaterialDocumentItem_2.StorageLocation,
          I_MaterialDocumentItem_2.MaterialBaseUnit,
          I_MaterialDocumentItem_2.Batch
