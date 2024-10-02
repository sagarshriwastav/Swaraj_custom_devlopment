@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BAGS, LOT No., Mill No.'

define view entity YDATA_GR_PRINT as select from I_StockQuantityCurrentValue_2(P_DisplayCurrency : 'INR' ) as a 
     left outer join I_BatchDistinct as b on ( b.Batch = a.Batch and b.Material = a.Product )
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as c on ( c.ClassType = '023' and c.ClfnObjectTable = 'MCH1'
                                                               and c.ClfnObjectInternalID = b.ClfnObjectInternalID
                                                               and c.CharcInternalID = '0000000818' ) // lotnumber
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as d on ( d.ClassType = '023' and d.ClfnObjectTable = 'MCH1'
                                                               and d.ClfnObjectInternalID = b.ClfnObjectInternalID
                                                               and d.CharcInternalID = '0000000819' ) // millname
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as e on ( e.ClassType = '023' and d.ClfnObjectTable = 'MCH1'
                                                               and e.ClfnObjectInternalID = b.ClfnObjectInternalID
                                                               and e.CharcInternalID = '0000000814' )      // no of bags  
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as f on ( f.ClassType = '023' and d.ClfnObjectTable = 'MCH1'
                                                               and f.ClfnObjectInternalID = b.ClfnObjectInternalID
                                                               and f.CharcInternalID = '0000000815' )      // no of cones 
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as g on ( g.ClassType = '023' and d.ClfnObjectTable = 'MCH1'
                                                               and g.ClfnObjectInternalID = b.ClfnObjectInternalID
                                                               and g.CharcInternalID = '0000000821' )      //per cone wieght      
    left outer join ZI_ClfnCharcValueDesc_cds as h on ( h.mil = d.CharcValue and h.CharcInternalID = '0000000819' and 
                                                  h.Language = 'E' )                                                                                                                                                                    
   left outer join I_MaterialDocumentItem_2 as I on ( I.Material = a.Product and I.Plant = a.Plant
                                                    and I.Batch = a.Batch and I.StorageLocation = 'YRM1'
                                                    and I.GoodsMovementType = '101' )
                                                                                                      

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
        cast(case when e.CharcFromDecimalValue > 0 then  I.QuantityInBaseUnit / cast( f.CharcFromDecimalValue as abap.dec( 13, 3 ) )
        else 0 end as abap.dec( 13, 3 ) ) as AvgPrConeWt,
        I.PostingDate
 
  } 
      where  a.MatlWrhsStkQtyInMatlBaseUnit > 0 and a.ValuationAreaType = '1' 
      and ( a.ProductType = 'ZYRJ' or  
       a.ProductType = 'ZYRP' or 
       a.ProductType = 'ZYOP' )
      
