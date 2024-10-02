@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds Yarn / Beam Stock Report'
define root view entity ZMM_YARN_BEAM_STOCK_CDS 
   as select from I_StockQuantityCurrentValue_2(P_DisplayCurrency : 'INR' ) as a 
     left outer join I_BatchDistinct as b on ( b.Batch = a.Batch and b.Material = a.Product )
     
      left outer join ZMM_JOB_REC_REG_INTERNALID_1 as t on ( t.ClassType = '023' and t.ClfnObjectTable = 'MCH1'
                                                               and t.ClfnObjectInternalID = b.ClfnObjectInternalID )
     
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as c on ( c.ClassType = '023' and c.ClfnObjectTable = 'MCH1'
                                                               and c.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and c.CharcInternalID = t.Lotnumber )  // '0000000807' ) // lotnumber
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as d on ( d.ClassType = '023' and d.ClfnObjectTable = 'MCH1'
                                                               and d.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and d.CharcInternalID = t.Milname ) // '0000000806' ) // millname
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as e on ( e.ClassType = '023' and e.ClfnObjectTable = 'MCH1'
                                                               and e.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and e.CharcInternalID =  t.NoOFbags ) // '0000000808' )      // no of bags  
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as f on ( f.ClassType = '023' and f.ClfnObjectTable = 'MCH1'
                                                               and f.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and f.CharcInternalID = t.Noofcone ) // '0000000809' )      // no of cones 
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as g on ( g.ClassType = '023' and g.ClfnObjectTable = 'MCH1'
                                                               and g.ClfnObjectInternalID = b.ClfnObjectInternalID
                                                               and g.CharcInternalID = '0000000821' )      //per cone wieght      
    left outer join ZI_ClfnCharcValueDesc_cds as h on ( h.mil = d.CharcValue and h.CharcInternalID = t.Milname and // '0000000806' and 
                                                  h.Language = 'E' )                                                                                                                                                                    
   left outer join I_MaterialDocumentItem_2 as I on ( I.Material = a.Product and I.Plant = a.Plant
                                                    and I.Batch = a.Batch and I.StorageLocation = 'YRM1'
                                                    and I.GoodsMovementIsCancelled = ' '
                                                    and ( I.GoodsMovementType = '501' or I.GoodsMovementType = '561' ) )                                                
  left outer join I_Customer      as K on ( K.Customer = I.Customer )                                            
  left outer join I_MaterialDocumentHeader_2 as J on ( J.MaterialDocument = I.MaterialDocument and 
                                                     J.MaterialDocumentYear = I.MaterialDocumentYear )                                                  
                                                                                                      

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
        cast(case when f.CharcFromDecimalValue > 0 then  I.QuantityInBaseUnit / cast( f.CharcFromDecimalValue as abap.dec( 13, 3 ) )
        else 0 end as abap.dec( 13, 3 ) ) as AvgPrConeWt,
        I.PostingDate,
        I.SalesOrder,
        I.SalesOrderItem,
        I.Customer,
        I.GoodsRecipientName,
        I.MaterialDocumentItemText,
        J.ReferenceDocument,
        K.CustomerName 
 
  } 
      where  a.MatlWrhsStkQtyInMatlBaseUnit > 0 and a.ValuationAreaType = '1' 
      and ( a.ProductType = 'ZYRJ' or  
       a.ProductType = 'ZWRJ' or  
       a.ProductType = 'ZDYJ'  )
      
