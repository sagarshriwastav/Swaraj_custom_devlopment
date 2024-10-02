@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Wise  Report'
define root view entity ZMM_YARN_STOCK_CDS 
  // with parameters 
      // P_DisplayCurrency : abap.cuky( 5 )
      // P_Days     : abap.dats
   as select from I_StockQuantityCurrentValue_2(P_DisplayCurrency : 'INR' ) as a 
     left outer join I_BatchDistinct as b on ( b.Batch = a.Batch and b.Material = a.Product  ) 
     
     left outer join ZMM_JOB_REC_REG_INTERNALID_1 as t on ( t.ClassType = '023' and t.ClfnObjectTable = 'MCH1'
                                                               and t.ClfnObjectInternalID = b.ClfnObjectInternalID )
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as c on ( c.ClassType = '023' and c.ClfnObjectTable = 'MCH1'
                                                               and c.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and c.CharcInternalID = t.Lotnumber )  // = '0000000807' ) // lotnumber
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as d on ( d.ClassType = '023' and d.ClfnObjectTable = 'MCH1'
                                                               and d.ClfnObjectInternalID = b.ClfnObjectInternalID
                                                               and d.CharcInternalID  = t.Milname )   //  = '0000000806' ) // millname
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as e on ( e.ClassType = '023' and e.ClfnObjectTable = 'MCH1'
                                                               and e.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and e.CharcInternalID  = t.NoOFbags )  // = '0000000808' )      // no of bags  
   
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as f on ( f.ClassType = '023' and f.ClfnObjectTable = 'MCH1'
                                                               and f.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and f.CharcInternalID  = t.Noofcone )  // = '0000000809' )      // no of cones 
  
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as g on ( g.ClassType = '023' and g.ClfnObjectTable = 'MCH1'
                                                               and g.ClfnObjectInternalID = b.ClfnObjectInternalID
                                                               and g.CharcInternalID = '0000000821' )      //per cone wieght 
    
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as l on ( l.ClassType = '023' and l.ClfnObjectTable = 'MCH1'
                                                               and l.ClfnObjectInternalID = b.ClfnObjectInternalID
                                                               and l.CharcInternalID = '0000000810' )    // SupplierCsp     0000000845                                                          
   
    left outer join ZI_ClfnCharcValueDesc_cds as h on ( h.mil = d.CharcValue and h.CharcInternalID = '0000000807' and 
                                                  h.Language = 'E' )                                                                                                                                                                    
   left outer join I_MaterialDocumentItem_2 as I on ( I.Material = a.Product and I.Plant = a.Plant
                                                    and I.Batch = a.Batch //and I.StorageLocation = 'YRM1' or I.StorageLocation = 'VJOB'
                                                    and I.GoodsMovementIsCancelled = ' ' 
                                                    and ( I.GoodsMovementType = '101' or I.GoodsMovementType = '561' )
                                                    and ( I.StorageLocation = 'YRM1' or I.StorageLocation = 'VJOB' ) 
                                                    and I.OrderID = '' )                                           
   left outer join I_PurchaseOrderItemAPI01    as j on (j.PurchaseOrder = I.PurchaseOrder and j.PurchaseOrderItem = I.PurchaseOrderItem )
   left outer join I_Supplier as k on ( k.Supplier = j.Subcontractor )     
   left outer join zpp_yarn_testing as AA on ( AA.material = a.Product and AA.batch = a.Batch )  
   left outer join zpp_yarn_testtem as AB on ( AB.partybillnumber = AA.partybillnumber and AB.parmeters = 'CSP' 
                                             and AB.partycode = right(I.Supplier ,7) )                                                                                                                  

{
    key a.Product,
        a.ProductType,
        a.ProductGroup,
        a.Plant,
        a.StorageLocation,
        a.Batch,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        a.MatlWrhsStkQtyInMatlBaseUnit  as stock,
        a.MaterialBaseUnit,
        @Semantics.amount.currencyCode: 'Currency'
        a.StockValueInDisplayCurrency,
        @Semantics.amount.currencyCode: 'Currency'
        a.StockValueInCCCrcy,
        a.Currency,
        b.ClfnObjectInternalID,
        c.CharcValue as lotno,
        d.CharcValue  as milno,
        l.CharcFromNumericValue as SupplierCsp,
       min( AB.zresult ) as Supplierlsp,
        cast( e.CharcFromDecimalValue as abap.dec( 13, 3 ) ) as NoofBags ,
        cast( f.CharcFromDecimalValue as abap.dec( 13, 3 ) )  as  NoOfCones,
        cast( g.CharcFromDecimalValue as abap.dec( 13, 3 ) )  as  PerConesWeight,
        h.CharcValueDescription,
 //       I.MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
         I.QuantityInBaseUnit  as MadockQty,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        cast(case when e.CharcFromDecimalValue > 0 then  I.QuantityInBaseUnit / cast( e.CharcFromDecimalValue as abap.dec( 13, 3 ) )
        else 0 end as abap.dec( 13, 3 ) ) as AvgPrBagWt,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        cast(case when e.CharcFromDecimalValue > 0 then  I.QuantityInBaseUnit / cast( f.CharcFromDecimalValue as abap.dec( 13, 3 ) )
        else 0 end as abap.dec( 13, 3 ) ) as AvgPrConeWt,
        I.PostingDate,
        a.SDDocument as SalesOrder,
        a.SDDocumentItem as SalesOrderItem,
        j.Subcontractor,
        @Semantics.amount.currencyCode: 'Currency'
        j.NetPriceAmount,
        k.SupplierName,
        case when dats_days_between( I.PostingDate, $session.system_date ) > 0
               then dats_days_between( I.PostingDate, $session.system_date )
               else dats_days_between( I.PostingDate, $session.system_date ) * -1 end as zdays
 
  } 
      where  a.MatlWrhsStkQtyInMatlBaseUnit > 0 and a.ValuationAreaType = '1' 
      and ( a.ProductType = 'ZYRJ' or  
       a.ProductType = 'ZYRP' or 
       a.ProductType = 'ZYOP' )
       
       group by AB.zresult,
                a.Product,
        a.ProductType,
        a.ProductGroup,
        a.Plant,
        a.StorageLocation,
        a.Batch,
         a.MatlWrhsStkQtyInMatlBaseUnit,
        a.MaterialBaseUnit,
         a.StockValueInDisplayCurrency,
          a.StockValueInCCCrcy,
        a.Currency,
        b.ClfnObjectInternalID,
        c.CharcValue ,
        d.CharcValue ,
        l.CharcFromNumericValue ,
        e.CharcFromDecimalValue,
        f.CharcFromDecimalValue,
        g.CharcFromDecimalValue ,
         h.CharcValueDescription,
          I.QuantityInBaseUnit,
           I.PostingDate,
        a.SDDocument,
        a.SDDocumentItem ,
        j.Subcontractor,
        j.NetPriceAmount,
        k.SupplierName 
      
