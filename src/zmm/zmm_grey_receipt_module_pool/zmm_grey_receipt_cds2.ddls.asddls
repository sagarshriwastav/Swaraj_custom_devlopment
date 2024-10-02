@AbapCatalog.sqlViewName: 'YGREYCDS2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Program'
define view ZMM_GREY_RECEIPT_CDS2 as select from ZMM_GREY_RECEIPT_CDS1 as A 
//left outer join I_MaterialDocumentItem_2 as b on ( b.Batch  = A.Batch  )
left outer join  ZMM_GREY_RECEIPT_REGISTER_CDS as b on  (  b.Supplier = A.Supplier and  b.PurchaseOrder = A.PurchaseOrder and  b.PurchaseOrderItem
 = b.PurchaseOrderItem    )
 
//  
{
    key A.Batch,
    key A.PurchaseOrder,
    key A.PurchaseOrderItem,
    A.Material543,
    A.Material,
    A.BaseUnit,
    A.OrderQuantity,
    A.BeamLenght,
    A.SalesOrder,
    A.SalesOrderItem,
    A.Supplier,
    A.SupplierName,
    A.ProductDescription,
    A.loom,
    A.pick,
    A.partybeam,
    A.FINISHROLL,
    A.SetDate,
    A.SetApproved,
    A.Daygs,
    b.MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   sum(b.QuantityInBaseUnit ) as grey_recpit
}  
where Daygs <= 90 

group by A.Batch,
     A.PurchaseOrder,
     A.PurchaseOrderItem,
    A.Material543,
    A.Material,
    A.BaseUnit,
    A.OrderQuantity,
    A.BeamLenght,
    A.SalesOrder,
    A.SalesOrderItem,
    A.Supplier,
    A.SupplierName,
    A.ProductDescription,
    A.loom,
    A.pick,
    A.partybeam,
    A.FINISHROLL,
    A.SetDate,
    A.SetApproved,
    A.Daygs,
    b.MaterialBaseUnit
 
