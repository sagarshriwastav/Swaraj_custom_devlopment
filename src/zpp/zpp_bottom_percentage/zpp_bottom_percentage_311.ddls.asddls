@AbapCatalog.sqlViewName: 'YBOTTOMPER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Bottom Percentage Report'
define view ZPP_BOTTOM_PERCENTAGE_311 as select from I_MaterialDocumentItem_2 as a 
left outer join I_MaterialDocumentHeader_2 as b on (b.MaterialDocument = a.MaterialDocument and b.MaterialDocumentYear = a.MaterialDocumentYear )
{
   key a.IssgOrRcvgBatch as Batch,
   key a.Material,
   key a.Plant,
       case when b.MaterialDocumentHeaderText = '' or b.MaterialDocumentHeaderText is null or b.MaterialDocumentHeaderText is initial
       then b.ReferenceDocument else b.MaterialDocumentHeaderText end as MaterialDocumentHeaderText
} 
  where a.GoodsMovementType = '311' and a.GoodsMovementIsCancelled = '' 

group by 
  a.IssgOrRcvgBatch,
  a.Material, 
  a.Plant,
  b.ReferenceDocument,
  b.MaterialDocumentHeaderText
