@AbapCatalog.sqlViewName: 'YARNCON1200'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Consumption Report'
define view ZMM_YARN_CONSUMPTION_CDS_1200  
                with parameters 
            @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
                as select from I_MaterialDocumentItem_2 as a   
   inner join ymseg4 as CNCL on ( CNCL.MaterialDocument = a.MaterialDocument 
                                 and CNCL.MaterialDocumentItem = a.MaterialDocumentItem
                                 and CNCL.MaterialDocumentYear = a.MaterialDocumentYear  )
   inner join  I_GoodsMovementCube as CODE on ( CODE.Batch                    = a.Batch 
                                                and CODE.Material             = a.Material
                                                and CODE.MaterialDocument     = a.MaterialDocument 
                                                and CODE.MaterialDocumentItem = a.MaterialDocumentItem
                                                and CODE.MaterialDocumentYear = a.MaterialDocumentYear
                                                                                                          )            
 left outer join I_ProductDescription as B on (  B.Product = a.Material and B.Language = 'E')
 left outer join  I_Product as c on ( c.Product = a.Material )
 
{   
    
    key a.Material,
    key a.Batch,
    key a.Plant,
        a.PurchaseOrder,
        a.PurchaseOrderItem,
        a.MaterialBaseUnit,
        substring(a.Supplier,4,7) as Supplier,
        a.Supplier as Supplier541,
        case when a.GoodsMovementType = '541' and a.DebitCreditCode = 'S'   then sum( a.QuantityInBaseUnit ) end as YARNRECEIVED,
        case when a.GoodsMovementType = '542' and a.DebitCreditCode = 'H'   then sum( a.QuantityInBaseUnit ) end as YARNRETURN,
          B.ProductDescription
    
}   where c.IndustryStandardName = 'E' and ( ( a.GoodsMovementType = '541' and CODE.GoodsMovementReasonCode = '0000' ) 
                                           or ( a.GoodsMovementType = '542' and CODE.GoodsMovementReasonCode = '0002'  ) )
         and ( a.Material like 'YDP%' or a.Material like 'YGP%' )  and ( a.InventorySpecialStockType = 'O' or a.InventorySpecialStockType = 'F' )
         and a.PostingDate > $parameters.p_posting  and a.PostingDate <= $parameters.p_posting1
    group by 
      a.Material,
      a.Batch,
      a.Plant,
      a.PurchaseOrder,
      a.PurchaseOrderItem,
      a.Supplier,
      a.MaterialBaseUnit,
      a.DebitCreditCode,
      a.GoodsMovementType,
      a.InventorySpecialStockType,
      B.ProductDescription
