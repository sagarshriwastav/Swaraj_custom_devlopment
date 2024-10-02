//@AbapCatalog.sqlViewName: 'YGREYRC'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Cds For Grey Receipt Module Pool Screen'
@AbapCatalog.sqlViewName: 'YGREYRC'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Module Pool Screen'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view ZMM_GREY_RECEIPT_CDS as select from I_MaterialDocumentItem_2 as a 

       left outer  join  ZI_MaterialDocumentItem_REV as CODE on ( CODE.Batch = a.Batch 
                                                and CODE.Material = a.Material
                                                and CODE.Plant = a.Plant 
                                                and CODE.PurchaseOrder = a.PurchaseOrder
                                                and CODE.PurchaseOrderItem = a.PurchaseOrderItem   
                                                 ) 
                                                 
       left outer join I_PurchaseOrderItemAPI01 as b on ( b.PurchaseOrder = a.PurchaseOrder 
                                                         and b.PurchaseOrderItem = a.PurchaseOrderItem ) 
       left outer join I_PurOrdAccountAssignmentAPI01    as c on  ( c.PurchaseOrder = a.PurchaseOrder 
                                                         and c.PurchaseOrderItem = a.PurchaseOrderItem )
                                                                                                            
      left outer join I_Supplier as d on ( d.Supplier = a.Supplier )                                                
      left outer join I_ProductDescription as e on ( e.Product = b.Material and e.Language = 'E' )  
      left outer join zsubcon_head as f on ( f.dyebeam = a.Batch )   
      left outer join ZMM_GREY_RECEIPT_BATCH_COUNT2 as g on (g.Batch = a.Batch ) 
      left outer join ZDNM_DD as H on ( H.ZfsetNo = a.Batch )
      left outer join zpp_approval_tab as I on ( I.setnumber = a.Batch and I.programno = '03' )                                            
                                                 
{
   
    key a.Batch,
    key a.PurchaseOrder,
    key a.PurchaseOrderItem,
        a.Material as Material543,
        b.Material, 
        b.BaseUnit,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        b.OrderQuantity,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        a.QuantityInEntryUnit as BeamLenght,
        c.SalesOrder,
        c.SalesOrderItem,
        a.Supplier,
        d.SupplierName,
        CODE.REVERS,
        e.ProductDescription,
        f.loom,
        f.pick,
        f.partybeam,
        case when g.alphabet =  '' or g.alphabet is null then  
        concat(a.Batch,'A') else 
        concat(a.Batch,g.alphabet) end as FINISHROLL,
        H.SateDate as SetDate,
        case when I.setnumber is not null or I.setnumber <> '' or I.setnumber is not initial
        then 'Approved' else '' end as SetApproved,
        $session.system_date as dats,
        a.PostingDate  
        
   
}   where ( a.GoodsMovementType = '541' ) 
       and a.DebitCreditCode = 'S' and a.GoodsMovementIsCancelled = '' 
   //    and CODE.GoodsMovementReasonCode = ''
  //     and CODE.GoodsMovementReasonCode <> '0002'
 
