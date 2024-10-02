@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Grn'
define root view entity ZPP_GOODS101 as select from I_MaterialDocumentItem_2 as a 
     inner join ymseg4 as b on ( b.MaterialDocument = a.MaterialDocument 
                                 and b.MaterialDocumentItem = a.MaterialDocumentItem
                                 and b.MaterialDocumentYear = a.MaterialDocumentYear )
{
   key  a.Plant,
    key a.Batch 
   
}   where a.GoodsMovementType = '101' and a.Material like 'FG%'
     
group by 
  a.Plant,
  a.Batch 
