@AbapCatalog.sqlViewName: 'YPURCHASESALES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase And Sales Report'
define view ZMM_PURCHASE_SALES_CDS as select from I_MaterialDocumentItem_2 as a
   left outer join I_MaterialDocumentItem_2 as b on ( b.Material = a.Material and b.Batch = a.Batch 
                                                     and b.GoodsMovementType = '101' 
                                                     and b.GoodsMovementIsCancelled = '' and b.Plant = '1210'  )
   left outer join I_MaterialDocumentItem_2 as F on ( F.Material = a.Material and F.Batch = a.Batch 
                                                     and F.GoodsMovementType = '601'
                                                     and F.GoodsMovementIsCancelled = '' and F.Plant = '1210'  )
                                                     
   left outer join I_SalesDocumentItem  as g on (g.SalesDocumentItem = a.SalesOrderItem and g.SalesDocument = a.SalesOrder )                                                
                                                                                                     
  left outer join I_MaterialDocumentHeader_2 as c on (c.MaterialDocument = b.MaterialDocument and c.MaterialDocumentYear = b.MaterialDocumentYear )
  left outer join I_Customer  as e on ( e.Customer = a.Customer )

 {
   key a.Material,
   key a.Batch,
       e.Customer,
       e.CustomerName,
       a.MaterialBaseUnit,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
       a.QuantityInEntryUnit as DeliveryQty,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
       b.QuantityInEntryUnit as PurchaseQty,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
       F.QuantityInEntryUnit as SalesQty1210,
       a.PostingDate as ChallanDate,
       b.PostingDate as PurchaseDate,
       F.PostingDate as InvocieDate,
       c.MaterialDocumentHeaderText as BillNumber,
       g.YY1_Grade1_SDI as Grade 
 } 
  where a.GoodsMovementType = '601' and a.GoodsMovementIsCancelled = ''
   and a.Plant = '1200' and e.Customer = '0006100010'  and a.Material like 'FFO%'
