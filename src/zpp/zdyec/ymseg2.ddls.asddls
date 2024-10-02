@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ymseg2 Cds For Is Cancel Material Flag'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YMSEG2
  as select distinct from I_MaterialDocumentItem_2
{
  key ReversedMaterialDocument,
  key ReversedMaterialDocumentItem,
  key ReversedMaterialDocumentYear
}
