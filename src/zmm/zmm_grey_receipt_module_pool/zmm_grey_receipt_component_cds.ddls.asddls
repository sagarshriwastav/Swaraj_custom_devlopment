@AbapCatalog.sqlViewName: 'YGREY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Module Pool Screen'
define view ZMM_GREY_RECEIPT_COMPONENT_CDS as select from I_POSubcontractingCompAPI01 as a
//      left outer join I_MaterialDocumentItem_2 as b on ( b.PurchaseOrder = a.PurchaseOrder 
//                                                         and b.PurchaseOrderItem = a.PurchaseOrderItem 
//                                                         and b.GoodsMovementType = '541' and b.DebitCreditCode = 'S') 
      inner join I_ProductDescription as c on ( c.Product = a.Material and c.Language = 'E' )
       left outer join I_PurOrdAccountAssignmentAPI01    as d on  ( d.PurchaseOrder = a.PurchaseOrder 
                                                         and d.PurchaseOrderItem = a.PurchaseOrderItem ) 

{
    key a.Material ,
    key a.PurchaseOrder,
    key a.PurchaseOrderItem,
        a.BaseUnit,
//        b.Batch,
        a.RequiredQuantity,
        a.WithdrawnQuantity,
        ( a.RequiredQuantity - a.WithdrawnQuantity ) as  RemainingQty,
        c.ProductDescription,
        d.SalesOrder,
        d.SalesOrderItem
        
}
