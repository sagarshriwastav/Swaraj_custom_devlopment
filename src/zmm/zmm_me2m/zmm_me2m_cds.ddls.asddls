@AbapCatalog.sqlViewName: 'YME2M'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Po Order Report'
define view ZMM_ME2M_CDS as select from I_PurchaseOrderAPI01 as a
left outer join I_PurchaseOrderItemAPI01 as b on ( b.PurchaseOrder = a.PurchaseOrder ) 
left outer join I_MaterialDocumentItem_2  as c on ( c.PurchaseOrder = b.PurchaseOrder and c.PurchaseOrderItem = b.PurchaseOrderItem  
                                                  and c.GoodsMovementType = '101' and c.GoodsMovementIsCancelled <> ' ' )
left outer join ZMM_ME2M_HISTORY as e on ( e.PurchaseOrder = b.PurchaseOrder and e.PurchaseOrderItem = b.PurchaseOrderItem 
                                                 )  
left outer join ZMM_ME2M_HISTORY_INV as f on ( f.PurchaseOrder = b.PurchaseOrder and f.PurchaseOrderItem = b.PurchaseOrderItem 
                                                 )                                                                                                                                                    
left outer join I_Supplier as d on ( d.Supplier = a.Supplier )
    
{
  key a.PurchaseOrder,
  key b.PurchaseOrderItem,
     a.PurchaseOrderType , 
     a.PurchaseOrderDate,
     a.Supplier,
     a.PurchasingGroup,
     a.PurchasingOrganization,
     a.YY1_MillName_PDH,
     b.DocumentCurrency,
     b.BaseUnit,
     @Semantics.amount.currencyCode: 'DocumentCurrency'
     b.NetAmount,
     @Semantics.amount.currencyCode: 'DocumentCurrency'
     b.GrossAmount,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     b.OrderQuantity,
     @Semantics.amount.currencyCode: 'DocumentCurrency'
     b.NetPriceAmount,
     b.PurchasingDocumentDeletionCode,
     b.IsCompletelyDelivered,  
     b.Material,
     b.Plant,
     b.StorageLocation,
     b.AccountAssignmentCategory,
     b.TaxCode,
     b.PurchaseOrderQuantityUnit,
     b.PurchaseOrderItemText,
     c.PostingDate,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     c.QuantityInBaseUnit,
     b.YY1_Salesorder_PDI,
     b.YY1_SalesOrderItem_PDI,
     d.SupplierName,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     e.Quantity as  GRNQUANTITY,
     @Semantics.amount.currencyCode: 'DocumentCurrency'
     e.PurchaseOrderAmount as GRNAMOUNT,
     @Semantics.quantity.unitOfMeasure: 'BaseUnit'
     sum(f.Quantity) as  InvocieQUANTITY,
     @Semantics.amount.currencyCode: 'DocumentCurrency'
     sum(f.InvoiceAmtInCoCodeCrcy ) as InvoiceAMOUNT
     
}   where  b.PurchasingDocumentDeletionCode = ''
  
  group by 
     a.PurchaseOrder,
     b.PurchaseOrderItem,
     a.PurchaseOrderType , 
     a.PurchaseOrderDate,
     a.Supplier,
     a.PurchasingGroup,
     a.PurchasingOrganization,
     a.YY1_MillName_PDH,
     b.DocumentCurrency,
     b.BaseUnit,
     b.NetAmount,
     b.GrossAmount,
     b.OrderQuantity,
     b.NetPriceAmount,
     b.PurchasingDocumentDeletionCode,
     b.IsCompletelyDelivered,  
     b.Material,
     b.Plant,
     b.StorageLocation,
     b.AccountAssignmentCategory,
     b.TaxCode,
     b.PurchaseOrderQuantityUnit,
     b.PurchaseOrderItemText,
     c.PostingDate,
     c.QuantityInBaseUnit,
     b.YY1_Salesorder_PDI,
     b.YY1_SalesOrderItem_PDI,
     d.SupplierName,
     e.Quantity,
     e.PurchaseOrderAmount
