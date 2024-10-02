@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DELIVERY PICK RATE REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZDELIVERY_PICK_RATE as select from I_DeliveryDocumentItem as A
 inner join I_SalesDocItemPricingElement as B on ( B.SalesDocument = A.ReferenceSDDocument
                                              and B.SalesDocumentItem = A.ReferenceSDDocumentItem
                                              and B.ConditionType = 'ZPIK' )
 left outer join ZJOB_GREY_NETWT_DISPATCH_CDS as C on ( C.Material = A.Material 
                                 and C.Recbatch = A.Batch and C.Plant = A.Plant ) 
                                                                              
 {
key A.DeliveryDocument,
key A.HigherLvlItmOfBatSpltItm as DELIVERYDOCUMENTITEM,
    A.Plant,
    A.Material,
    A.DeliveryDocumentItemText,
    A.BaseUnit,
    A.Batch,
    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    sum( A.ActualDeliveryQuantity ) as DELIVERY_QTY ,
    B.TransactionCurrency,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    B.ConditionRateValue as PICKRATE ,
    C.pick ,
   cast(cast( case when sum(A.ActualDeliveryQuantity) is not null then 
       sum(A.ActualDeliveryQuantity) else 0 end as abap.dec( 13, 3 ) ) * 
   ( cast( case when B.ConditionRateValue is not null then B.ConditionRateValue  else 0 end as abap.dec( 13, 2 ) ) *
   ( cast( case when C.pick is not null then C.pick else 0 end as abap.dec( 6, 2 ) ) ) )
   as abap.dec( 13, 2 ) )
   as amt
  
    
  
} where A.HigherLvlItmOfBatSpltItm is not initial
group by A.DeliveryDocument, A.HigherLvlItmOfBatSpltItm,
    A.Batch,A.Plant,
    A.Material,
    A.DeliveryDocumentItemText,
    A.BaseUnit,B.ConditionRateValue,B.TransactionCurrency,C.pick
   
