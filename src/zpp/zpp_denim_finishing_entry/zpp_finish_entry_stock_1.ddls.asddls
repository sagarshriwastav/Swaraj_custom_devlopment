@AbapCatalog.sqlViewName: 'YDENSTK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Finish Entry'
define view ZPP_FINISH_ENTRY_STOCK_1 as select from ZPP_FINISH_ENTRY_STOCK2  as a 
    inner join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
    left outer join ZPP_FINISH_ENTRY_BYSUPPLIERMAT as c on ( c.Material = a.Material and c.Batch = a.Batch )
    left outer join ZPP_FINISH_ENTRY_SUPPLIER2 as d on ( d.Batch = a.Batch and d.Material = a.Material  )
    left outer join zsubcon_item as e on ( e.rollno = c.BatchBySupplier )
     left outer join ZMM_GREY_RECEIPT_REP as n on ( n.Piecenumber = a.Batch and n.Itemcode = a.Material 
                                                    and n.Supplier = d.Supplier )
{
    key a.Material,
    key a.Plant,
    key a.StorageLocation,
    key a.Batch,
    a.MaterialBaseUnit,
    a.Stock,
    b.ProductDescription,
    case when c.BatchBySupplier = '' then
    a.Batch else c.BatchBySupplier end as BatchBySupplier,
     n.Suppliername,
     n.Supplier,
     n.Loom  as loom,
     case when c.BatchBySupplier = '' then
     n.Setnumber else c.BatchBySupplier end as SetnumberPieceNo
    
}   where  a.Stock > 0
