@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Yarn Pack Cds View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YPP_ORDERCOMPONENT as select from I_MfgOrderOperationComponent as 
      a
      
//     inner join YY1_PACKINGTYPE as c on ()
//    inner  join I_Plant as p on ( a.ProductionPlant = p.Plant )
////     left outer join I_Plant as q on ( a.PlanningPlant = p.Plant )
    inner  join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
//     left outer join I_Customer as cus on (  b.SoldToParty = cus.Customer  )
//    inner join I_MaterialStock as c on (c.Plant = a.Plant)
   left outer join YPP_COMPONENT_STOCK as c on ( c.Material = a.Material and c.Plant = a.Plant
                                              and c.StorageLocation = a.StorageLocation and c.Batch = a.Batch )
 {  
  key a.ManufacturingOrder, 
   key  a.Plant, 
        a.Material,
        b.ProductDescription,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        a.RequiredQuantity,
        a.BaseUnit,
        a.Batch,
        a.StorageLocation,
         a.SalesOrder,
        a.SalesOrderItem,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        c.STOCKQTY
       
//    a.ManufacturingOrderCategory,
//    a.ManufacturingOrderType,   
//    a.OrderIsReleased,
//    a.StorageLocation, 
//    a.BaseUnit,  
//      @Semantics.quantity.unitOfMeasure: 'BaseUnit' 
//    a.MfgOrderItemPlannedTotalQty  as Orderqty,
//      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
//    a.MfgOrderItemGoodsReceiptQty as Grqty,
////    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
//    a.OrderIsReleased  as orderreleased,
//    a.IsMarkedForDeletion,
//    a.IsCompletelyDelivered,
//    a.OrderItemIsNotRelevantForMRP,
//    a.Material,
//    a.Product,
//    a.ProductionPlant,
//    a.PlanningPlant,
//    a.MRPController,
//    a.SalesOrder,
//    a.SalesOrderItem,
//     b.SoldToParty,
//    p.PlantName as ProductionPlantname,
////    q.PlantName as PlanningPlantname,
//    r.ProductDescription as materialdescription,
//    cus.CustomerName,
//    s.YY1_PackingType_ORD,
//    s.YY1_TapeConeTip_ORD
//    
}
where a.MatlCompIsMarkedForDeletion != 'X'
//group by
//  a.Material,
//  a.Plant,
//  a.ManufacturingOrder,
//  b.ProductDescription,
//  a.RequiredQuantity,
// a.BaseUnit,
//  a.Batch,
//  a.StorageLocation
