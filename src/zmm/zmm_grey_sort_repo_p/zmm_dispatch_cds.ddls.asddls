@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DISPATCH CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_DISPATCH_CDS as select from  YSDCDS_PENDING_ORDER_L1 as A 
{
  key A.Product,
      A.OrderQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      A.OrderQuantity,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      A.Delivery_Quantity,
      @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
      A.Pending_Order_Qty,
     @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    sum(case when A.YY1_Grade1_SDI like 'FR' then (A.OrderQuantity)  end  )  as fresh,
         @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    sum(case when A.YY1_Grade1_SDI like 'SW' then (A.OrderQuantity)  end  )  as SW,
         @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    sum(case when A.YY1_Grade1_SDI like 'CD' then (A.OrderQuantity)  end  )  as CD,
     @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    sum(case when A.YY1_Grade1_SDI like 'SV' then (A.OrderQuantity)  end  )  as SV,
     @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
    sum(case when A.YY1_Grade1_SDI like 'SL' then (A.OrderQuantity)  end  )  as SL
    
} 
 group by A.Product,
          A.OrderQuantityUnit,
          A.OrderQuantity,
        A.Delivery_Quantity,
      A.Pending_Order_Qty
