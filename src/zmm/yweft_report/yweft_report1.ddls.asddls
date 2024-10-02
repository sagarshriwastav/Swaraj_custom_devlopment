@AbapCatalog.sqlViewName: 'YWFT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YWEFT_REPORT_CDS'
define view YWEFT_REPORT1 as select from I_PurchaseOrderAPI01 as A
         left outer join I_PurchaseOrderItemAPI01 as B on ( B.PurchaseOrder = A.PurchaseOrder )
         left outer join I_POSubcontractingCompAPI01 as C on ( C.PurchaseOrder = B.PurchaseOrder and C.PurchaseOrderItem = B.PurchaseOrderItem 
                                                           and C.Plant = B.Plant and C.Material like 'Y%' )
        left outer join YWEFT_REPORT_cds541 as e on ( e.PurchaseOrder = C.PurchaseOrder and e.PurchaseOrderItem = C.PurchaseOrderItem 
                                                             and e.Material = C.Material 
                                                            and e.Plant = C.Plant )
                                                             
       left outer join YWEFT_REPORT_cds542 as f on ( f.PurchaseOrder = e.PurchaseOrder and f.PurchaseOrderItem = e.PurchaseOrderItem 
                                                            and f.Material = e.Material and f.Plant = e.Plant 
                                                            and f.Batch = e.Batch )
                                                                                                                  
        left outer join I_BatchDistinct as n on ( n.Batch = e.Batch and n.Material = e.Material )
     
       left outer join ZMM_JOB_REC_REG_INTERNALID_1 as u on ( u.ClassType = '023' and u.ClfnObjectTable = 'MCH1'
                                                               and u.ClfnObjectInternalID = n.ClfnObjectInternalID 
                                                                 )
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as o on ( o.ClassType = '023' and o.ClfnObjectTable = 'MCH1'
                                                               and o.ClfnObjectInternalID = u.ClfnObjectInternalID
                                                               and o.CharcInternalID = u.Lotnumber ) // '0000000807' ) // lotnumber
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as p on ( p.ClassType = '023' and p.ClfnObjectTable = 'MCH1'
                                                               and p.ClfnObjectInternalID = u.ClfnObjectInternalID
                                                               and p.CharcInternalID = u.Milname ) // '0000000806' ) // millname
                                                               
     left outer join ZI_ClfnCharcValueDesc_cds as t on ( t.mil = p.CharcValue and t.CharcInternalID = u.Milname and  // '0000000806' and 
                                                  t.Language = 'E' )     
    left outer join I_Supplier as SUP on (SUP.Supplier = A.Supplier )
    left outer join I_ProductDescription_2 as DES on ( DES.Product = B.Material and DES.Language  = 'E' )                                                                                                   
                                                                                                                  
{
    key A.PurchaseOrder as PO ,
        B.PurchaseOrderItem as PO_ITEM ,
        B.Material as Grey_Fabric,
        B.Plant,
        B.OrderQuantity as PlannedGreyQuantity ,
        B.YY1_SalesOrderItem_PDI as SO,
        B.YY1_Salesorder_PDI as SO_Item,
        C.Material as Component ,
        sum(C.RequiredQuantity) as WeftRequiredQty ,
        A.Supplier as Party_Code,
        e.Batch,
        e.QuantityInEntryUnit  as QuantityInEntryUnit541 ,
        e.MaterialBaseUnit,
        f.QuantityInEntryUnit as QuantityInEntryUnit542,
        n.ClfnObjectInternalID,
        o.CharcValue as lotno,
        p.CharcValue  as milno,
        t.CharcValueDescription,
        SUP.SupplierName,
        DES.ProductDescription

}
where
A.PurchaseOrderType = 'ZFB3'  and C.Material <> ' '

group by

        A.PurchaseOrder  ,
        B.PurchaseOrderItem  ,
        B.Material ,
        B.Plant,
        B.OrderQuantity  ,
        B.YY1_SalesOrderItem_PDI ,
        B.YY1_Salesorder_PDI ,
        C.Material  ,
        A.Supplier ,
        e.Batch,
        e.QuantityInEntryUnit,
        e.MaterialBaseUnit,
        f.QuantityInEntryUnit,
        n.ClfnObjectInternalID,
        o.CharcValue ,
        p.CharcValue ,
        t.CharcValueDescription,
        SUP.SupplierName,
        DES.ProductDescription
