@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BIMWISE SUBCON DISPATCH REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZBEAMWISE_SUB_DOC_CDS as select from I_MaterialDocumentItem_2
{
    key Plant,
    key MaterialDocument,
    key MaterialDocumentYear,
    key MaterialDocumentItem,
    case when MaterialDocumentItem is initial
      then '000000' 
      else
      cast( cast( concat( '00', MaterialDocumentItem ) as abap.numc( 6  ) )   
      as abap.numc( 6  ) ) end as ZMaterialDocumentItem ,
      PostingDate,
      PurchaseOrder,
      PurchaseOrderItem,
      Supplier,
      DebitCreditCode
}
  where GoodsMovementType = '541' and DebitCreditCode = 'S' 
