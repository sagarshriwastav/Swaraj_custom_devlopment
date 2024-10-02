@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Material Receipt report'
define root view entity ZMM_MATERIAL_RECEIPT_CDS1 as select from I_MaterialDocumentHeader_2   as a 
                     left outer join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.MaterialDocument and 
                                                                      b.MaterialDocumentYear = a.MaterialDocumentYear )
                     left outer join I_Supplier as g on ( g.Supplier = b.Supplier)
                     left outer join I_ProductDescription as h on ( h.Product = b.Material and h.Language = 'E')                                                 
                     left outer join I_PurchaseOrderItemAPI01 as c on ( c.PurchaseOrder = b.PurchaseOrder 
                                                                   and c.PurchaseOrderItem = b.PurchaseOrderItem )  
                     left outer join I_PurchaseOrderAPI01 as d on ( d.PurchaseOrder = b.PurchaseOrder )                                                
                     left outer join I_PurchaseRequisitionItemAPI01 as e on ( e.PurchaseRequisition = c.PurchaseRequisition 
                                                                      and  e.PurchaseRequisitionItem = c.PurchaseRequisitionItem )
                     left outer join ZPP_GET_ENTRY_NO as f on ( f.ebeln = b.PurchaseOrder  and f.ebelp = b.PurchaseOrderItem and
                        (f.invoice =  a.MaterialDocumentHeaderText)  )
      //    left outer join YY1_GATEENTRY as f on 
        
     left outer join I_BatchDistinct as n on ( n.Batch = b.Batch and n.Material = b.Material )
     
       left outer join ZMM_JOB_REC_REG_INTERNALID_1 as u on ( u.ClassType = '023' and u.ClfnObjectTable = 'MCH1'
                                                               and u.ClfnObjectInternalID = n.ClfnObjectInternalID )
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as o on ( o.ClassType = '023' and o.ClfnObjectTable = 'MCH1'
                                                               and o.ClfnObjectInternalID = u.ClfnObjectInternalID
                                                               and o.CharcInternalID = u.Lotnumber ) // '0000000807' ) // lotnumber
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as p on ( p.ClassType = '023' and p.ClfnObjectTable = 'MCH1'
                                                               and p.ClfnObjectInternalID = u.ClfnObjectInternalID
                                                               and p.CharcInternalID = u.Milname ) // '0000000806' ) // millname
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as q on ( q.ClassType = '023' and q.ClfnObjectTable = 'MCH1'
                                                               and q.ClfnObjectInternalID = u.ClfnObjectInternalID
                                                               and q.CharcInternalID = u.NoOFbags ) // '0000000808' )      // no of bags 
                                                                
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as s on ( s.ClassType = '023' and s.ClfnObjectTable = 'MCH1'
                                                               and s.ClfnObjectInternalID = u.ClfnObjectInternalID
                                                               and s.CharcInternalID =  u.Noofcone ) // '0000000809' )      // no of cones 
                                                               
     left outer join ZI_ClfnCharcValueDesc_cds as t on ( t.mil = p.CharcValue and t.CharcInternalID = u.Milname and  // '0000000806' and 
                                                  t.Language = 'E' )
     left outer join I_PurOrdScheduleLineAPI01 as w on ( w.PurchaseOrder = c.PurchaseOrder and w.PurchaseOrderItem = c.PurchaseOrderItem )
     left outer join ZMM_MATERIAL_RECEIPT_CDS_BEAM as v on (  v.Plant = b.Plant 
                               and v.StorageLocation = b.StorageLocation and v.Batch = b.Batch 
                               and v.MaterialDocumentYear = b.MaterialDocumentYear  )
     left outer join  zpp_yarn_testing as Gss on  ( Gss.partybillnumber = a.ReferenceDocument and a.ReferenceDocument <> '')                       
     left outer join ZPP_YARN_HEAD_TEAST as aa on ( aa.Batch = b.Batch  )  
     left outer join ZI_SupplierInvoiceAPI01 as bb on ( ( bb.ReferenceDocument = b.MaterialDocument  and bb.ReferenceDocumentItem = b.MaterialDocumentItem  
                                                       ) ) 
     left outer join I_PurchaseOrderHistoryAPI01 as VV on ( VV.PurchasingHistoryDocument = b.MaterialDocument  and VV.PurchasingHistoryDocumentItem = b.MaterialDocumentItem and VV.PurchasingHistoryCategory = 'E' and VV.Quantity > 0)                                                      
    
    left outer join ZI_SupplierInvoiceAPI01 as cc on  ( VV.ReferenceDocument = cc.ReferenceDocument  and VV.ReferenceDocumentItem = cc.ReferenceDocumentItem
                                                      and bb.PurchasingHistoryDocument is null ) //)                                     
//    left outer join I_MaterialDocumentItem_2  as oo on ( b.Material = oo.Material and b.Batch = oo.Batch )
    left outer join ZI_MaterialDocumentItem_REV101 as Rev on ( Rev.Batch = b.Batch and Rev.Material = b.Material 
                                                            and Rev.PurchaseOrder = b.PurchaseOrder 
                                                            and Rev.PurchaseOrderItem = b.PurchaseOrderItem )
{
    key a.MaterialDocument,
    key a.MaterialDocumentYear, 
    key a.DocumentDate,
    key a.PostingDate,
        a.Plant,
        a.StorageLocation,
        b.Plant as ChmlPlant,
        b.StorageLocation as ChmlStorageLocation,
       case when a.ReferenceDocument = '' then a.MaterialDocumentHeaderText else a.ReferenceDocument end as ReferenceDocument ,
        b.PurchaseOrder,
        b.PurchaseOrderItem,
        w.ScheduleLineDeliveryDate,
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
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//        case when  b.DebitCreditCode = 'H' then
//        ( b.QuantityInBaseUnit ) * -1 else b.QuantityInBaseUnit end as QuantityInBaseUnit,  
        case when    b.QuantityInBaseUnit =  0    then   b.QuantityInEntryUnit else b.QuantityInBaseUnit end as QuantityInBaseUnit,
        b.CompanyCodeCurrency,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        case when  b.DebitCreditCode = 'H' then
        (b.TotalGoodsMvtAmtInCCCrcy) * -1 else b.TotalGoodsMvtAmtInCCCrcy end as TotalGoodsMvtAmtInCCCrcy,
        b.GoodsMovementRefDocType,
        b.GoodsMovementIsCancelled,
        c.BaseUnit,
        c.MaterialGroup,
        c.MaterialType,
        c.PurchaseRequisition,
        c.PurchaseRequisitionItem,
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
        c.RequisitionerName,
        c.RequirementTracking,
        c.PurchaseOrderItemCategory,
        d.PurchaseOrderDate,
        d.PurchaseOrderType,
        e.PurchaseRequisitionType,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        e.RequestedQuantity,
        e.PurReqCreationDate,
        e.DeliveryDate,
        max(f.gateno) as gateno,
        max(f.vehical_no ) as vehical_no,
        max(f.gate_in_date) as gate_in_date,
        n.ClfnObjectInternalID,
        o.CharcValue as lotno,
        p.CharcValue  as milno,
        t.CharcValueDescription,
        bb.SupplierInvoiceIDByInvcgParty,
        bb.DocumentDate as  INVOICE_DATE,
        case when Gss.batch <> ' '  then 'Tested' end as Testing,
        cast(case when b.GoodsMovementType = '101' then
        cast( q.CharcFromDecimalValue as abap.dec( 23, 3 ) ) 
        when v.PrBagKg <> 0 then ( b.QuantityInBaseUnit / v.PrBagKg ) * -1  else
        0 end as abap.dec( 23, 3 ) ) as NoofBags,

              cast(case when b.GoodsMovementType = '101' then
        cast( s.CharcFromDecimalValue as abap.dec( 23, 3 ) ) 
        when v.PrConeKg <> 0 then  -1 *( b.QuantityInBaseUnit / v.PrConeKg ) else 0 end as abap.dec( 23, 3 ) ) as NoOfCones,
          aa.ActualCount,
          
         case when bb.PurchasingHistoryDocument is null then cc.PurchasingHistoryDocument 
         else bb.PurchasingHistoryDocument end as MIR7NO,
//         bb.PurchasingHistoryDocument as MIR7NO,
          case when bb.PurchasingHistoryDocument is null then cc.PurchasingHistoryDocument 
         else bb.PurchasingHistoryDocument end as PurchasingHistoryDocument,
//         bb.PurchasingHistoryDocument as PurchasingHistoryDocument ,
     //     bb.SupplierPostingLineItemText
         case when bb.PurchasingHistoryDocument is null then cc.SupplierPostingLineItemText 
         else bb.SupplierPostingLineItemText end as ItemText,
//         bb.SupplierPostingLineItemText as ItemText,
          @Semantics.amount.currencyCode: 'DocumentCurrency'
       //   bb.InvoiceAmtInCoCodeCrcy 
         case when bb.PurchasingHistoryDocument is null then cc.PurchaseOrderAmount 
         else bb.PurchaseOrderAmount end
         as InvoiceValue,
//         bb.InvoiceAmtInCoCodeCrcy as InvoiceValue,
         // f.GateInDate,  
          b.MaterialDocumentItemText as BatchBySupplier,
      //    bb.SupplierInvoiceStatus 
         case when bb.PurchasingHistoryDocument is null then cc.SupplierInvoiceStatus  
         else bb.SupplierInvoiceStatus  end as InvoiceStatus,
//         bb.SupplierInvoiceStatus as InvoiceStatus,
          case when bb.PurchasingHistoryDocument is null then cc.PostingDate 
         else bb.PostingDate end as InvoicePostingDate,
//         bb.PostingDate as InvoicePostingDate,
          case when bb.PurchasingHistoryDocument is null then cc.SupplierInvoice 
         else bb.SupplierInvoice end as SupplierInvoice,
//         bb.SupplierInvoice as SupplierInvoice
          Rev.REVERS,
//           @Semantics.quantity.unitOfMeasure: 'BaseUnit'
//          b.QuantityInEntryUnit,
//          @Semantics.amount.currencyCode: 'DocumentCurrency'
//          bb.PurchaseOrderAmount,
          c.PurchaseOrderItemText
          
       
    
    
} where  b.GoodsMovementRefDocType = 'B' and a.AccountingDocumentType = 'WE' and ( b.GoodsMovementType = '101' 
                                         or b.GoodsMovementType = '161' or b.GoodsMovementType = '122' )
           and b.GoodsMovementIsCancelled = ''   
  //         and VV.Quantity > 0
    group by        
    a.MaterialDocument,
     a.MaterialDocumentYear,
     a.DocumentDate,
     b.TotalGoodsMvtAmtInCCCrcy,
     a.PostingDate,
     q.CharcFromDecimalValue,
     v.PrBagKg,
     v.PrConeKg,
     s.CharcFromDecimalValue,
        a.Plant,
        a.ReferenceDocument,
        a.MaterialDocumentHeaderText,
        b.QuantityInBaseUnit,
        a.StorageLocation,
        b.Plant ,
        b.CompanyCodeCurrency,
        b.StorageLocation ,
        b.GoodsMovementRefDocType,
        b.GoodsMovementIsCancelled,
        c.BaseUnit,
        Gss.batch,
        c.MaterialGroup,
        c.MaterialType,
        c.PurchaseRequisition,
        c.PurchaseRequisitionItem,
        c.AccountAssignmentCategory,
        c.DocumentCurrency,
        b.PurchaseOrder,
        b.PurchaseOrderItem,
        w.ScheduleLineDeliveryDate,
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
      c.NetAmount,
       c.GrossAmount,
       c.OrderQuantity,
        c.NetPriceAmount,
        c.TaxCode,
        c.BR_NCM,
        c.RequisitionerName,
        c.RequirementTracking,
        c.PurchaseOrderItemCategory,
        d.PurchaseOrderDate,
        d.PurchaseOrderType,
        e.PurchaseRequisitionType,
       e.RequestedQuantity,
        e.PurReqCreationDate,
        e.DeliveryDate,
 //       f.gateno,
//        f.vehical_no,
        n.ClfnObjectInternalID,
        o.CharcValue ,
        p.CharcValue ,
        t.CharcValueDescription,
        aa.ActualCount,
          bb.PurchasingHistoryDocument ,
          cc.PurchasingHistoryDocument ,
          bb.SupplierPostingLineItemText ,
          cc.SupplierPostingLineItemText ,
          bb.InvoiceAmtInCoCodeCrcy ,
          cc.InvoiceAmtInCoCodeCrcy,
          bb.PurchasingHistoryDocument,
//          f.gateno,  
          b.MaterialDocumentItemText ,
          bb.SupplierInvoiceStatus ,
          cc.SupplierInvoiceStatus ,
          bb.PostingDate ,
          cc.PostingDate ,
          bb.SupplierInvoice,
          cc.SupplierInvoice ,
//          f.gate_in_date,
           bb.SupplierInvoiceIDByInvcgParty,
        bb.DocumentDate,
          Rev.REVERS,
          b.QuantityInEntryUnit,
          bb.PurchaseOrderAmount,
          c.PurchaseOrderItemText,
          cc.PurchaseOrderAmount
          
         
           
                                   
