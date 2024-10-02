//@AbapCatalog.sqlViewName: 'YGREYDATE'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Cds For Grey Entry Date SetWise'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Ymseg1 Cds For Is Cancel Material Flag'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_GREY_ENTRY_DATE_SETWISE as select from I_MaterialDocumentItem_2 as a
{
   key a.Plant, 
   key substring(a.Batch,1,(length(a.Batch)-1)) as SetNumber,
       min(a.PostingDate) as GreyDate
}  where a.GoodsMovementType = '543' and a.GoodsMovementIsCancelled = ''
  group by 
    a.Plant,
    a.Batch
