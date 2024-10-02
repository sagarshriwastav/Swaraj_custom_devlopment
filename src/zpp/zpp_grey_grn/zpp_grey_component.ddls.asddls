@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS For Grey Component Detail'
define root view entity ZPP_Grey_Component as select from  I_ReservationDocumentItem as a
inner join I_ReservationDocumentHeader as b on (b.Reservation = a.Reservation)
inner join I_ManufacturingOrderItem as c on (c.ManufacturingOrder = b.OrderID)
inner join I_ProductDescription as d on ( d.Product = a.Product and d.Language = 'E' )
left outer join I_MaterialStock as e on ( e.Material = a.Product and e.Plant = a.Plant  )
inner join I_MfgOrderOperationComponent as f on (f.Reservation = a.Reservation and f.ReservationItem = a.ReservationItem)
left outer join I_MfgOrderWithStatus    as g on ( g.ManufacturingOrder = b.OrderID )
 

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
  d.ProductDescription,
  @Semantics.quantity.unitOfMeasure: 'baseunit'
  sum( e.MatlWrhsStkQtyInMatlBaseUnit ) as StockQty,
  f.SalesOrder,
  f.SalesOrderItem
//  a.RequiredQuantity,
// a.WithdrawnQuantity,
//  a.BaseUnit

    
}  where ( a.ReservationItmIsMarkedForDeltn = ' ' or g.OrderIsTechnicallyCompleted = 'X' ) // and a.Product like 'S%'
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
          d.ProductDescription,
          f.SalesOrder,
          f.SalesOrderItem
          
