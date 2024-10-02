@AbapCatalog.sqlViewName: 'YTRANS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Tranfer Posting'
define view ZPP_TRANSFER_POSTING_CDS as select from I_MaterialStock_2 as a 
      inner join ZPP_TRANSFER_POSTING_SUM as c on ( c.Material = a.Material and c.Batch = a.Batch 
                                                   and c.Plant = a.Plant and c.StorageLocation = a.StorageLocation 
                                                  and c.SDDocument = a.SDDocument
                                                  and c.SDDocumentItem = a.SDDocumentItem 
                                                 )
       left outer join I_ProductDescription  as b on  ( b.Product = a.Material and b.Language = 'E' )
       left outer join I_SalesDocumentItem  as d on ( d.SalesDocument = a.SDDocument and d.SalesDocumentItem = a.SDDocumentItem )
       left outer join zpp_finishing as E on (  E.finishrollno = a.Batch  )
    
   
{
    key a.Plant,
    key a.Material,
    key a.Batch,
        a.StorageLocation,
        a.StorageLocation as IssuingOrReceivingStorageLoc,
        a.SDDocument as SalesOrder,
        a.SDDocumentItem as SalesOrderItem,
        a.MaterialBaseUnit,
        b.ProductDescription,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        c.StockQty,
        d.YY1_Grade1_SDI as Grade,
        left (E.setpeiceno , 7 ) as SETCODE
} where c.StockQty  > 0 and a.StorageLocation <> ''
   
   group by   
        a.Plant,
        a.Material,
        a.Batch,
        a.StorageLocation,
        a.SDDocument,
        a.SDDocumentItem,
        a.MaterialBaseUnit,
        b.ProductDescription,
        c.StockQty,
        d.YY1_Grade1_SDI,
        E.setpeiceno
