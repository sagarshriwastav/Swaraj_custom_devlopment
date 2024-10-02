@AbapCatalog.sqlViewName: 'YSUMCHEMICAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Chemical Stock Report'
define view ZMM_CHEMICAL_STOCK2 as select from I_StockQuantityCurrentValue_2( P_DisplayCurrency:'INR')as A
                     left outer join I_ProductDescription as B on ( B.Product = A.Product  and B.Language = 'E' )
                     left outer join ZI_StockQuantityCurren_CDS as gs on ( gs.Product = A.Product  and gs.Plant = A.Plant )
                     left outer join I_MaterialDocumentItem_2 as C on ( C.Material = A.Product and C.Batch = A.Batch and C.GoodsMovementType = '101' 
                                                                     and C.GoodsMovementIsCancelled = '' )
                     left outer join I_PurchaseOrderItemAPI01 as d on ( d.PurchaseOrder = C.PurchaseOrder and d.PurchaseOrderItem = C.PurchaseOrderItem )
                     left outer join  I_MaterialDocumentItem_2 as e on ( e.Material = A.Product and e.Batch = A.Batch and e.StorageLocation = A.StorageLocation
                                                                         and e.GoodsMovementType = '311' and e.GoodsMovementIsCancelled = '' 
                                                                         )
                     
                     
                 
                                          
{
key A.Plant ,
key A.StorageLocation,
key A.Product as Material ,
 B.ProductDescription as Material_Description ,
 A.Batch,
 cast(A.MatlWrhsStkQtyInMatlBaseUnit as abap.dec( 13,3 ) ) as Quantity,
 A.MaterialBaseUnit as Quantity_Unit ,
 C.PostingDate as Arrived_In_Plant_Date,
 C.QuantityInEntryUnit as Arrived_In_Plant_Quantity,
 d.NetPriceAmount as Purchase_Rate_Per_Unit,
 d.DocumentCurrency as Currency,
 A.MatlWrhsStkQtyInMatlBaseUnit * d.NetPriceAmount as Valuation_As_Per_Purchase_Rate ,
 max(e.PostingDate) as Arrived_In_Location_Date ,
 case when e.DebitCreditCode = 'H' then  e.QuantityInEntryUnit * -1 else 
  e.QuantityInEntryUnit end as QuantityInEntryUnit,
 gs.TotalStockInPlant,
 $session.system_date as SYSTUMDATE
 
    
}

where A.ValuationAreaType = '1'  and A.Product like 'S%'

group by

A.Plant,
A.StorageLocation,
A.Product,
B.ProductDescription,
A.Batch,
A.MatlWrhsStkQtyInMatlBaseUnit,
A.MaterialBaseUnit,
C.PostingDate,
C.QuantityInEntryUnit,
d.NetPriceAmount,
d.DocumentCurrency,
gs.TotalStockInPlant,
e.DebitCreditCode ,
e.QuantityInEntryUnit
//e.PostingDate
