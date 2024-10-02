@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_MaterialDocumentItem_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_MaterialDocumentItem_CDS as select from I_MaterialDocumentItem_2 as A
{
    key A.MaterialDocument,
        A.MaterialDocumentYear,
        A.GoodsMovementIsCancelled,
        A.Batch,
        cast(A.QuantityInBaseUnit as abap.dec( 13, 2 )  ) as  QuantityInBaseUnit
       
    
} 
group by A.MaterialDocument,
        A.MaterialDocumentYear,
        A.GoodsMovementIsCancelled,
         A.Batch,
          A.QuantityInBaseUnit
