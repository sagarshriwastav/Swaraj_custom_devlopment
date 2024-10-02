@AbapCatalog.sqlViewName: 'ZSUBCON'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Subcon  Beam Detail'
define view ZPP_SUBCON_V1 as select from ZMM_SUB_CON_LATEST as Latest
     left outer join  I_MaterialDocumentItem_2 as a on (a.MaterialDocument = Latest.MaterialDocument and a.MaterialDocumentItem = Latest.MaterialDocumentItem 
                                               and a.MaterialDocumentYear = Latest.MaterialDocumentYear and a.Material = a.Material 
                                               and a.Batch = Latest.Batch )
     inner join ZPP_STOCKQTY_SUBCON_SUM as F on ( F.Batch = a.Batch and F.Material = a.Material )
     inner join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
     left outer join I_Supplier as c on ( c.Supplier = a.Supplier )
     left outer join zpp_dyeing1 as d on ( d.beamno = a.Batch )
//     left outer join zpc_headermaster as g on ( g.zpqlycode = d.greyshort )  
     inner join  ymseg4 as e on ( e.MaterialDocument = a.MaterialDocument 
                                 and e.MaterialDocumentYear = a.MaterialDocumentYear 
                                  and e.MaterialDocumentItem = a.MaterialDocumentItem )
    left outer join zsubcon_head as h on (h.dyebeam = a.Batch  and h.party = right(a.Supplier,7)  ) 
//*********** added    
    right outer join zpp_sortmaster as i on ( i.material = d.greyshort )                             
{
    key Latest.MaterialDocument, 
    key Latest.MaterialDocumentItem,
    key Latest.MaterialDocumentYear,
        Latest.Material,
        b.ProductDescription,
        Latest.Plant,
        Latest.StorageLocation,
        Latest.Batch,
        a.EntryUnit,
        a.GoodsMovementType,
        a.PurchaseOrder,
        a.PostingDate,
        @Semantics.quantity.unitOfMeasure: 'EntryUnit'
        a.QuantityInBaseUnit,
        a.SalesOrder,
        a.SalesOrderItem,
        a.Supplier,
        c.SupplierName,
        d.remark,
        d.greyshort,
        d.pipenumber,
        d.shade,
//        g.zptotends,
//        g.zppicks,
//        g.zpreedspace,
//        g.zpreed1,
//        g.zdent,
        h.loom,
        h.partybeam,
        h.date2,
        h.dyebeam,
//        ADDING FIELDS FABRIC SORT MODULE
        i.dent,
        i.reed,
        i.reedspace,
        i.pick,
        i.totalends,
        i.dyeingshade
        
        
} 
