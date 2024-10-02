@AbapCatalog.sqlViewName: 'YREPORT_PAC1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PACKING_REPORT_NEW'
define view YPACKING_REP as select from I_MaterialDocumentItem_2 as A
        inner join I_ProductDescription as B on ( B.Product = A.Material
                                              and B.Language = $session.system_language )
       left outer join YPACKNCDS_N as C on  ( C.Batch = A.Batch  )                                     
{   
    key A.MaterialDocument,
    key A.MaterialDocumentItem,
    key A.MaterialDocumentYear,
        A.Plant,
        A.StorageLocation,
        A.Batch,
        A.PostingDate,
        A.Material,
        B.ProductDescription,
        A.GoodsMovementType,
        A.SalesOrder,
        A.SalesOrderItem,
        A.MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        A.QuantityInBaseUnit,
        A.MaterialDocumentItemText,
        C.LotNumber
    
        
    
}
