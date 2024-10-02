@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyeing Prod Entry'
define root view entity ZPP_DYEING_ENTRY_CDS1 as select from  I_ReservationDocumentItem as a
inner join I_ReservationDocumentHeader as b on (b.Reservation = a.Reservation)
inner join I_ManufacturingOrderItem as c on (c.ManufacturingOrder = b.OrderID)
inner join I_ProductDescription as d on ( d.Product = a.Product and d.Language = 'E' )
inner join I_MfgOrderOperationComponent as f on (f.Reservation = a.Reservation and f.ReservationItem = a.ReservationItem) 
inner join I_MfgOrderWithStatus as g on ( g.ManufacturingOrder = b.OrderID )
left outer join I_MaterialStock as e on ( e.Material = a.Product and e.Plant = a.Plant and e.StorageLocation = a.StorageLocation
                                     and e.Batch = a.Batch  and e.SDDocument = f.SalesOrder 
                                     and e.SDDocumentItem = f.SalesOrderItem )
                                    

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
// a.MatlCompIsMarkedForDeletion,
  f.SalesOrder,
  f.SalesOrderItem
//  a.RequiredQuantity,
// a.WithdrawnQuantity,
//  a.BaseUnit

    
}  where a.Product like 'BW%' and ( a.ReservationItmIsMarkedForDeltn = ' ' or g.OrderIsTechnicallyCompleted = 'X' )
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
