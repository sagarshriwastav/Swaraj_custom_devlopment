@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Register Report'
define root view entity ZMM_GREY_RECEIPT_REGISTER_CDS as select from I_MaterialDocumentHeader_2   as a 
                     inner join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.MaterialDocument and 
                                                                      b.MaterialDocumentYear = a.MaterialDocumentYear  
                                                                       )
                      inner join ymseg4  as e on    ( e.MaterialDocument = b.MaterialDocument and 
                                                      e.MaterialDocumentItem = b.MaterialDocumentItem and 
                                                      e.MaterialDocumentYear = b.MaterialDocumentYear )                                          
                   left outer join I_Supplier as g on ( g.Supplier = b.Supplier)
                   inner join I_ProductDescription as h on ( h.Product = b.Material and h.Language = 'E')                                                 
                   left outer join I_PurchaseOrderItemAPI01 as c on ( c.PurchaseOrder = b.PurchaseOrder 
                                                                   and c.PurchaseOrderItem = b.PurchaseOrderItem )  
                   left outer join I_PurchaseOrderAPI01 as d on ( d.PurchaseOrder = b.PurchaseOrder ) 
                     
                   left outer join I_Batch as P on ( P.Batch = b.Batch and P.Material = b.Material  )  
                   left outer join ZMM_GREY_RECEIPT_REP as n on ( n.Piecenumber = b.Batch and n.Itemcode = b.Material 
                                                                and n.Po = b.PurchaseOrder and n.Poitem = b.PurchaseOrderItem
                                                                and n.MaterialDocumentItem = b.MaterialDocumentItem )
                   left outer join ZPP_GET_ENTRY_NO as q on ( q.invoice = n.Partychlaan )                                             
                   left outer join ZMM_GREY_RECEIPT_NETWT as R on ( b.Supplier = concat( '000',R.party ) and R.rollno = b.Batch )

                                                                                                                                                                          
   
{
    key a.MaterialDocument,
    key a.MaterialDocumentYear,
    key a.DocumentDate,
    key a.PostingDate,
        a.Plant,
        a.StorageLocation,
        a.ReferenceDocument,
        b.PurchaseOrder,
        b.PurchaseOrderItem,
        b.MaterialDocumentItem,  
        b.Material,
        h.ProductDescription,
        max(b.Batch) as Batch,
        b.SalesOrder,
        b.SalesOrderItem,
        b.Supplier,
        g.SupplierName,
        b.DebitCreditCode,
        b.GoodsMovementType,
        b.MaterialBaseUnit,
        cast( case when  b.DebitCreditCode = 'H'   then
        ( b.QuantityInBaseUnit ) * -1 else b.QuantityInBaseUnit end as abap.dec( 13, 3 ) ) as QuantityInBaseUnit,       
        b.CompanyCodeCurrency,
        c.BaseUnit,
        c.MaterialGroup,
        c.MaterialType,
        c.AccountAssignmentCategory,
        c.DocumentCurrency,
        @Semantics.amount.currencyCode: 'DocumentCurrency'
        c.NetAmount,
        @Semantics.amount.currencyCode: 'DocumentCurrency'
        c.GrossAmount,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        c.OrderQuantity,
        @Semantics.amount.currencyCode: 'DocumentCurrency'
        c.NetPriceAmount,
        c.TaxCode,
        c.BR_NCM,
        c.PurchaseOrderItemCategory,
        d.PurchaseOrderDate,
        d.PurchaseOrderType,
        case when P.BatchBySupplier <> '' then P.BatchBySupplier 
        else n.Setnumber end as BatchBySupplier,
        case when n.Partychlaan is not null then a.MaterialDocumentHeaderText else n.Partychlaan  end as Partychlaan ,
        count( distinct b.Batch ) as NoofPeaces,
        n.Grossweight,
        case when  n.Netweight is null
             then R.netwt
             else n.Netweight  end  as Netweight,
        n.internalbatch as internalbatch,
        q.gate_in_date,
        q.gateno,
        ( count( * ) - 1 ) as PcsNo,
       right(             n.Setnumber, 1            ) as Beam,
       left(             n.Setnumber, 7            ) as Set_code,
     //   count( distinct(n.Setnumber) ) as zpackage ,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        ( b.QuantityInBaseUnit * n.Netweight )  as AverageWeight,
         case when n.Setnumber is null then  b.MaterialDocumentItemText else n.Setnumber end as SetNumber,
         case when n.internalbatch is null then b.GoodsRecipientName else n.internalbatch end as internalbatch1
} where  
( b.Material like 'FG%' or b.Material like '0000000000077%' )
         and
          b.GoodsMovementRefDocType = 'B' and a.AccountingDocumentType = 'WE' 
         and b.GoodsMovementIsCancelled = ''
         and  b.GoodsMovementType = '101'   
         
         group by  
        a.MaterialDocument,
        a.MaterialDocumentYear,
        a.DocumentDate,
        a.PostingDate,
        a.Plant,
        a.StorageLocation,
        a.ReferenceDocument,
        a.MaterialDocumentHeaderText,
        b.PurchaseOrder,
        b.PurchaseOrderItem,
        b.MaterialDocumentItem,  
        b.Material,
        h.ProductDescription,
        b.Batch,
        b.SalesOrder,
        b.SalesOrderItem,
        b.Supplier,
        g.SupplierName,
        b.DebitCreditCode,
        b.GoodsMovementType,
        b.MaterialBaseUnit,
        b.QuantityInBaseUnit,       
        b.CompanyCodeCurrency,
        c.BaseUnit,
        c.MaterialGroup,
        c.MaterialType,
        c.AccountAssignmentCategory,
        c.DocumentCurrency,
        c.NetAmount,
        c.GrossAmount,
        c.OrderQuantity,
        c.NetPriceAmount,
        c.TaxCode,
        c.BR_NCM,
        c.PurchaseOrderItemCategory,
        d.PurchaseOrderDate,
        d.PurchaseOrderType,
        n.Setnumber,
        P.BatchBySupplier,
        n.Partychlaan,
        n.Grossweight,
        n.Netweight,
        n.internalbatch,
        b.MaterialDocumentItemText,
        b.GoodsRecipientName,
        q.gate_in_date,
        q.gateno,
        R.netwt
         
           
         
             
                                        
