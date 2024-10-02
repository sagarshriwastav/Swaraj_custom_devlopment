@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_MaterialDocumentItem_2'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_MaterialDocumentItem_2 as select from  ZI_MaterialDocumentItem_CDS as A
left outer join zmm_grey_receipt as B on ( A.MaterialDocument = B.matdocument
                                          and A.MaterialDocumentYear = B.matdocumentyear    
                                          and A.Batch = B.setnumber    )

{
  key B.setnumber ,
     
    sum(B.qtylength )  as qtylength
   /// sum(A.QuantityInBaseUnit  )  as qtylength
      
} 
 where A.GoodsMovementIsCancelled = ''
 
 group by
  B.setnumber 
  
