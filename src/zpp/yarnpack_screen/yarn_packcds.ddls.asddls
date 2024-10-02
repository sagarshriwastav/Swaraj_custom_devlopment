@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Yarn Pack Cds View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Yarn_packcds as select from I_ManufacturingOrderItem as 
      a left outer join I_SalesDocumentItem as b on  ( a.SalesOrder = b.SalesDocument  and a.SalesOrderItem = b.SalesDocumentItem )
//      inner join YY1_PACKINGTYPE as c on ()
    inner  join I_Plant as p on ( a.ProductionPlant = p.Plant )
//     left outer join I_Plant as q on ( a.PlanningPlant = p.Plant )
     inner  join I_ProductDescription as r on ( a.Material = r.Product and r.Language = 'E' )
     left outer join I_Customer as cus on (  b.SoldToParty = cus.Customer  )
     inner join I_ManufacturingOrder as s on (s.ManufacturingOrder = a.ManufacturingOrder)
 {  
  key a.ManufacturingOrder,
   key  a.ManufacturingOrderItem, 
        a.Batch,
       
    a.ManufacturingOrderCategory,
    a.ManufacturingOrderType,   
    a.OrderIsReleased,
    a.StorageLocation, 
    a.BaseUnit,  
      @Semantics.quantity.unitOfMeasure: 'BaseUnit' 
    a.MfgOrderItemPlannedTotalQty  as Orderqty,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    a.MfgOrderItemGoodsReceiptQty as Grqty,
//    @Semantics.quantity.unitOfMeasure: 'BaseUnit'
    a.OrderIsReleased  as orderreleased,
    a.IsMarkedForDeletion,
    a.IsCompletelyDelivered,
    a.OrderItemIsNotRelevantForMRP,
    a.Material,
    a.Product,
    a.ProductionPlant,
    a.PlanningPlant,
    a.MRPController,
    a.SalesOrder,
    a.SalesOrderItem,
     b.SoldToParty,
    p.PlantName as ProductionPlantname,
//    q.PlantName as PlanningPlantname,
    r.ProductDescription as materialdescription,
    cus.CustomerName
  //  s.YY1_PackingType_ORD,
  //  s.YY1_TapeConeTip_ORD
    
}
//where a.
