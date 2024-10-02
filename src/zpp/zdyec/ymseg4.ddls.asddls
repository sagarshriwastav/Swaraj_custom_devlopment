@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ymseg4 Cds For Is Cancel Material Flag'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ymseg4
  as select from ymseg3
{
  MaterialDocument,
  MaterialDocumentItem,
  MaterialDocumentYear
}
