@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ymseg3 Cds For Is Cancel Material Flag'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ymseg3
  as select distinct from YMSEG1 as a
  
{
  key a.MaterialDocument,
  key a.MaterialDocumentItem,
  key a.MaterialDocumentYear
}
where 
  (
    a.ReversedMaterialDocumentYear = '0000'
  )
except
(
  select from YMSEG2 as b
  {
    key ReversedMaterialDocument     as MaterialDocument,
    key ReversedMaterialDocumentItem as MaterialDocumentItem,
    key ReversedMaterialDocumentYear as MaterialDocumentYear
  }
)
