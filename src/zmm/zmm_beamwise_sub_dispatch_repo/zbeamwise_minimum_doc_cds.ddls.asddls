@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BIMWISE SUBCON DISPATCH REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBEAMWISE_MINIMUM_DOC_CDS as select from I_MaterialDocumentItem_2 as a 
          inner join ymseg4 as b on ( a.MaterialDocument = b.MaterialDocument 
                                      and a.MaterialDocumentItem = b.MaterialDocumentItem
                                      and a.MaterialDocumentYear = b.MaterialDocumentYear  )
{
    key a.Plant,
    key a.Batch,
    key a.MaterialDocumentYear,
    key a.MaterialDocumentItem,
    max( a.MaterialDocument) as materialdocument
    
}where a.GoodsMovementType = '541' and a.DebitCreditCode = 'S' 
 group by 
         a.Plant,
         a.MaterialDocumentYear,
         a.MaterialDocumentItem,
         a.Batch
