@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ymseg1 Cds For Is Cancel Material Flag'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YMSEG1
  as select distinct from I_MaterialDocumentItem_2
{
  key MaterialDocument,
  key MaterialDocumentItem,
  key MaterialDocumentYear,
      ReversedMaterialDocument,
      ReversedMaterialDocumentItem,
      ReversedMaterialDocumentYear
}
