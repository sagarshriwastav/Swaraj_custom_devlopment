@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'purchase order ite'
define root view entity YPURCHASE_ITEM
  as select from    I_PurchaseOrderItemAPI01   as a
    inner join      I_PurchaseOrderAPI01       as B on a.PurchaseOrder = B.PurchaseOrder 
    left outer join I_MaterialDocumentHeader_2 as c on a.PurchaseOrder = c.ReferenceDocument
    left outer join I_ProductText              as d on( a.Material     = d.Product and d.Language = 'E' )
    inner join      I_Supplier                 as e on( B.Supplier = e.Supplier )
    left outer join I_ProductPlantBasic        as f on( a.Material  = f.Product and f.Plant = a.Plant )
  //left outer  join I_MaterialDocumentItem_2 as g on ( A.PurchaseOrder = g.PurchaseOrder and
  //A.PurchaseOrderItem = g.PurchaseOrderItem
  //and g.GoodsMovementType = '101'
  //    )
    left outer join ZGetQuantity_CDS    as j on (  a.PurchaseOrder = j.ebeln and
                                                   a.PurchaseOrderItem =  j.ebelp )
{
  key a.PurchaseOrder,
  key a.PurchaseOrderItem,
      a.Plant ,
      a.Material,
      a.SupplierIsSubcontractor,
      a.OverdelivTolrtdLmtRatioInPct as TolerancePercentage,
      a.PurchaseOrderQuantityUnit,
      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      a.OrderQuantity,
      //        @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      case when a.OverdelivTolrtdLmtRatioInPct is not null
            then  cast( cast( a.OrderQuantity  as abap.fltp ) * (cast( a.OverdelivTolrtdLmtRatioInPct as abap.fltp ) + 100.00 ) / 100.00  as abap.dec(10,2) )
            else
            cast( a.OrderQuantity  as abap.dec(10,2)   )
            end                      as tolerancequantity,
      B.PurchaseOrderDate,
      B.PurchaseOrderType,
      B.PurchasingGroup,
      B.ReleaseIsNotCompleted,
      B.PurchasingProcessingStatus,
      B.Supplier                     as suppliernumber,
      c.MaterialDocument,
      c.PostingDate                  as grndate,
      d.ProductName,
      e.SupplierName                 as suppliername,
      f.ConsumptionTaxCtrlCode,
      //  @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      '0.00'                         as totalqty1,
      ////  @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      '0.00'                         as totalqty2,
      //  ,
   //   @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
      sum( j.gate_qty )                 as totalgatequantity

}
where a.PurchasingDocumentDeletionCode != 'L'

group by
  a.PurchaseOrder,
  a.PurchaseOrderItem,
  a.Plant ,
  a.OverdelivTolrtdLmtRatioInPct,
  a.Material,
  a.SupplierIsSubcontractor,
  a.PurchaseOrderQuantityUnit,
  //      @Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
  a.OrderQuantity,
  B.PurchaseOrderDate,
  B.PurchaseOrderType,
  B.PurchasingGroup,
  B.Supplier,
  B.ReleaseIsNotCompleted,
  B.PurchasingProcessingStatus,
  c.MaterialDocument,
  c.PostingDate,
  d.ProductName,
  e.SupplierName,
  f.ConsumptionTaxCtrlCode
