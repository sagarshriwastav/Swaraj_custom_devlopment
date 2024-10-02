@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS For Dye Set Component Details'
define root view  entity ZDYEC_SET_COMPONENT as select from  I_ReservationDocumentItem as a
inner join I_ReservationDocumentHeader as b on (b.Reservation = a.Reservation)
inner join I_ManufacturingOrderItem as c on (c.ManufacturingOrder = b.OrderID)
inner join I_ProductDescription as d on ( d.Product = a.Product and d.Language = 'E' )
//left outer join ZPP_STOCKQTY_CDS as e on ( e.Material = a.Product and e.Plant = a.Plant  and e.StorageLocation = 'DY01' )
inner join I_MfgOrderOperationComponent as g on (g.Reservation = a.Reservation and g.ReservationItem = a.ReservationItem )
left outer join ZPP_ALREADY_CON_QTY1 as f on ( f.Material = a.Product and f.Plant = a.Plant 
                                            and f.OrderID = b.OrderID and f.reciepeno = g.SortField )
inner join I_ProductDescription as h on ( h.Product = g.Assembly and d.Language = 'E' )
left outer join ZPP_DYEC_LASTUESD_GPL3 as I on ( I.chemical = a.Product and I.Dyeingsort = g.Assembly and I.reciepeno = g.SortField )
left outer join I_ProductValuationBasic as J on (J.Product = a.Product and J.ValuationArea = a.Plant )

{
  key a.Reservation,
  key a.ReservationItem,
  a.Plant,
  a.Product,
  a.Batch,
  a.StorageLocation,
  b.OrderID,
  a.ResvnItmRequiredQtyInBaseUnit,
  a.ResvnItmWithdrawnQtyInBaseUnit,
  a.BaseUnit,
  c.Batch as SetNumber,
  c.BaseUnit as MBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'MBaseUnit'
  c.MfgOrderPlannedTotalQty as SetLength,
  d.ProductDescription,
  g.SortField,
//  @Semantics.quantity.unitOfMeasure: 'baseunit'
//  sum( e.StockQty ) as StockQty,
//  e.Batch as StockQtyBatch,
   @Semantics.quantity.unitOfMeasure: 'baseunit'
  f.AlreadyQty,
  g.Assembly as recipe,
  h.ProductDescription as recipedes,
  @Semantics.quantity.unitOfMeasure: 'baseunit'
  I.consqty as LastUsedQty,
  J.Currency,
  @Semantics.amount.currencyCode: 'Currency'
  J.MovingAveragePrice as MvgAveragePriceInPreviousYear

    
}  where a.ReservationItmIsMarkedForDeltn = ' ' and a.Product like 'S%' 
  group by  
          a.Reservation,
          a.ReservationItem,
          a.Plant,
          a.Product,
          a.Batch,
          a.StorageLocation,
          b.OrderID,
          a.ResvnItmRequiredQtyInBaseUnit,
          a.ResvnItmWithdrawnQtyInBaseUnit,
          a.BaseUnit,
          c.Batch ,
          c.BaseUnit,
          d.ProductDescription,
          f.AlreadyQty,
          g.Assembly,
          h.ProductDescription,
          g.SortField,
          I.consqty,
          J.MovingAveragePrice,
          J.Currency,
          c.MfgOrderPlannedTotalQty
          
