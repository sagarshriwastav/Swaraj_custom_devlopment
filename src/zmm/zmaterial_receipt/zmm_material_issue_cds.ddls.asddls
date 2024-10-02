@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Material Issue report'
define root view entity ZMM_MATERIAL_ISSUE_CDS as select from I_MaterialDocumentHeader_2   as a 
                     left outer join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.MaterialDocument and 
                                                                      b.MaterialDocumentYear = a.MaterialDocumentYear 
                                                                       )
                     left outer join I_ProductDescription as h on ( h.Product = b.Material and h.Language = 'E')                                                 
          
          
        
     left outer join I_BatchDistinct as n on ( n.Batch = b.Batch and n.Material = b.Material )
     
     left outer join ZMM_JOB_REC_REG_INTERNALID_1 as w on ( w.ClassType = '023' and w.ClfnObjectTable = 'MCH1'
                                                               and w.ClfnObjectInternalID = n.ClfnObjectInternalID )
     
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as o on ( o.ClassType = '023' and o.ClfnObjectTable = 'MCH1'
                                                               and o.ClfnObjectInternalID = w.ClfnObjectInternalID
                                                               and o.CharcInternalID = w.Lotnumber ) // '0000000807' ) // lotnumber
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as p on ( p.ClassType = '023' and p.ClfnObjectTable = 'MCH1'
                                                               and p.ClfnObjectInternalID = w.ClfnObjectInternalID
                                                               and p.CharcInternalID =  w.Milname ) // '0000000806' ) // millname
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as q on ( q.ClassType = '023' and q.ClfnObjectTable = 'MCH1'
                                                               and q.ClfnObjectInternalID = w.ClfnObjectInternalID
                                                               and q.CharcInternalID = w.NoOFbags ) // '0000000808' )      // no of bags 
                                                                
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as s on ( s.ClassType = '023' and s.ClfnObjectTable = 'MCH1'
                                                               and s.ClfnObjectInternalID = w.ClfnObjectInternalID
                                                               and s.CharcInternalID =  w.Noofcone ) // '0000000809' )      // no of cones 
                                                               
     left outer join ZI_ClfnCharcValueDesc_cds as t on ( t.mil = p.CharcValue and t.CharcInternalID = w.Milname and  // '0000000806' and 
                                                  t.Language = 'E' )
                                                  
     left outer join ZMM_MATERIAL_ISSUE_CDS_BEAM as v on (  v.Plant = b.Plant 
                               and v.StorageLocation = b.StorageLocation and v.Batch = b.Batch 
                               and v.MaterialDocumentYear = b.MaterialDocumentYear  )
     left outer join I_CostCenterText  as c on ( c.CostCenter = b.CostCenter and c.Language = 'E') 
     left outer join  I_ReservationDocumentItem as d on ( d.Reservation = b.Reservation and d.ReservationItem = b.ReservationItem )      
   left outer join I_ProductValuationBasic   as e on (  e.Product = h.Product  and e.CompanyCode = '1000' )
                                                       
//     
//  left outer join I_ProductValuationBasic   as eE on (  eE.Product = b.Material and eE.ValuationArea = '1200') 
               

    {
    key a.MaterialDocument,
    key a.MaterialDocumentYear,
    key a.DocumentDate,
    key a.PostingDate,
        b.Plant,
        b.IssuingOrReceivingPlant,
        b.StorageLocation,
        b.IssuingOrReceivingStorageLoc,      
        a.ReferenceDocument,
        b.Reservation,
        b.ReservationItem,
        b.MaterialDocumentItem,  
        b.Material,
        h.ProductDescription,
        b.CostCenter,
        b.Batch,
        b.IssgOrRcvgBatch,
        b.SalesOrder,
        b.SalesOrderItem,
        b.DebitCreditCode,
        b.GoodsMovementType,
        b.MaterialBaseUnit,
        c.CostCenterDescription,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        case when  b.DebitCreditCode = 'H' then
        ( b.QuantityInBaseUnit ) * -1 else b.QuantityInBaseUnit end as QuantityInBaseUnit,       
        b.CompanyCodeCurrency,
       
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        case when  b.DebitCreditCode = 'H' then
        (b.TotalGoodsMvtAmtInCCCrcy) * -1 else b.TotalGoodsMvtAmtInCCCrcy end as TotalGoodsMvtAmtInCCCrcy,
        b.GoodsMovementRefDocType,
        b.GoodsMovementIsCancelled,
        n.ClfnObjectInternalID,
        o.CharcValue as lotno,
        p.CharcValue  as milno,
        t.CharcValueDescription,
        d.EntryUnit,
        @Semantics.quantity.unitOfMeasure: 'EntryUnit'
        d.ResvnItmRequiredQtyInEntryUnit,

        cast(case when b.GoodsMovementType = '101' then
        cast( q.CharcFromDecimalValue as abap.dec( 13, 3 ) ) else
       ( b.QuantityInBaseUnit / v.PrBagKg ) * -1 end as abap.dec( 13, 3 ) ) as NoofBags,

              cast(case when b.GoodsMovementType = '101' then
        cast( s.CharcFromDecimalValue as abap.dec( 13, 3 ) ) else
          -1 *( b.QuantityInBaseUnit / v.PrConeKg ) end as abap.dec( 13, 3 ) ) as NoOfCones,
          e.Currency,
          @Semantics.amount.currencyCode: 'Currency'
          e.MovingAveragePrice as MovingAveragePrice,
          @Semantics.amount.currencyCode: 'Currency'         
         case when e.StandardPrice is initial then e.MovingAveragePrice else e.StandardPrice end  as StandardPrice ,
//         when eE.StandardPrice is not initial then eE.StandardPrice \\\ e.InventoryValuationProcedure
             @Semantics.amount.currencyCode: 'Currency'
          e.StandardPrice as StandardPrice1,
          e.ValuationArea
//        cast( q.CharcFromDecimalValue as abap.dec( 13, 3 ) ) as NoofBags ,
   //     cast( s.CharcFromDecimalValue as abap.dec( 13, 3 ) )  as  NoOfCones,
        
        
    
    
} where  ( b.GoodsMovementType = '311' or b.GoodsMovementType = '312'  
           or b.GoodsMovementType = '201' or b.GoodsMovementType = '202'
           or  b.GoodsMovementType = '301' or b.GoodsMovementType = '302'   
           or b.GoodsMovementType = '261' or b.GoodsMovementType = '262' 
           or b.GoodsMovementType = '241' or b.GoodsMovementType = '242'   ) 
         and e.ValuationArea = '1200'
          
//           and e.MovingAveragePrice is not initial 
          
           group by 
        a.MaterialDocument,
        a.MaterialDocumentYear,
        a.DocumentDate,
        a.PostingDate,
        b.Plant,
        b.IssuingOrReceivingPlant,
        b.StorageLocation,
        b.IssuingOrReceivingStorageLoc,      
        a.ReferenceDocument,
        b.Reservation,
        b.ReservationItem,
        b.MaterialDocumentItem,  
        b.Material,
        h.ProductDescription,
        b.CostCenter,
        b.Batch,
        b.IssgOrRcvgBatch,
        b.SalesOrder,
        b.SalesOrderItem,
        b.DebitCreditCode,
        b.GoodsMovementType,
        b.MaterialBaseUnit,
        b.GoodsMovementRefDocType,
        b.GoodsMovementIsCancelled,
        c.CostCenterDescription,
        n.ClfnObjectInternalID,
        o.CharcValue,
        p.CharcValue,
        t.CharcValueDescription,
        b.QuantityInBaseUnit,
        b.CompanyCodeCurrency,
        b.TotalGoodsMvtAmtInCCCrcy,
        q.CharcFromDecimalValue,
        v.PrBagKg,
        s.CharcFromDecimalValue,
        v.PrConeKg,
        d.ResvnItmRequiredQtyInEntryUnit,
        d.EntryUnit,
        e.Currency,
//        eE.StandardPrice ,
        e.MovingAveragePrice , 
        e.StandardPrice,
        e.ValuationArea
//        e.InventoryValuationProcedure
       
                               
