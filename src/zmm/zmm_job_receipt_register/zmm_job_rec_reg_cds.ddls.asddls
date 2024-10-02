@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Receipt Register Report'
define root view entity ZMM_JOB_REC_REG_CDS as select from I_MaterialDocumentHeader_2 as a 
              left outer join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.MaterialDocument 
                                                               and b.MaterialDocumentYear = a.MaterialDocumentYear )
       left outer join I_BatchDistinct as s on ( s.Batch = b.Batch and s.Material = b.Material )
       
            left outer join ZMM_JOB_REC_REG_INTERNALID_1 as t on ( t.ClassType = '023' and t.ClfnObjectTable = 'MCH1'
                                                               and t.ClfnObjectInternalID = s.ClfnObjectInternalID )
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as c on ( c.ClassType = '023' and c.ClfnObjectTable = 'MCH1'
                                                               and c.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and c.CharcInternalID = t.Lotnumber )  //  = '0000000807' ) // lotnumber
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as d on ( d.ClassType = '023' and d.ClfnObjectTable = 'MCH1'
                                                               and d.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and d.CharcInternalID  = t.Milname ) // = '0000000806' ) // millname  
                                                               
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as e on ( e.ClassType = '023' and e.ClfnObjectTable = 'MCH1'
                                                               and e.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and e.CharcInternalID = t.NoOFbags )  // = '0000000808' )      // no of bags  
                                                               
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as f on ( f.ClassType = '023' and f.ClfnObjectTable = 'MCH1'
                                                               and f.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and f.CharcInternalID = t.Noofcone  ) // '0000000809' )      // no of cones 
                                                               
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as g on ( g.ClassType = '023' and g.ClfnObjectTable = 'MCH1'
                                                               and g.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and g.CharcInternalID = '0000000821' )      //per cone wieght      
    left outer join ZI_ClfnCharcValueDesc_cds as h on ( h.mil = d.CharcValue and h.CharcInternalID = t.Milname  and // '0000000806' and 
                                                  h.Language = 'E' ) 
                                                                                                                                                                                                                                                 
     left outer join ZMM_JOB_REC_REG_CDS_SUM as I on ( I.Material = b.Material and I.Plant = b.Plant
                                                    and I.Batch = b.Batch and I.StorageLocation = 'YRM1'
                                               
                                                     and I.MaterialDocumentYear = b.MaterialDocumentYear 
                                                    )    
      left outer join I_Customer      as K on ( K.Customer = b.Customer )                                                                                                                                                                 
                                                       
            
{
    key a.MaterialDocument,
    key a.MaterialDocumentYear,
        a.ReferenceDocument,
        a.DocumentDate,
        a.PostingDate,
        b.Customer,
        b.Material,
        b.Plant,
        b.StorageLocation,
        b.Batch,
        b.MaterialBaseUnit,
        b.GoodsRecipientName,
        b.MaterialDocumentItemText,
        b.UnloadingPointName ,
        s.ClfnObjectInternalID,
        c.CharcValue as lotno,
        d.CharcValue  as milno,
        cast( e.CharcFromDecimalValue as abap.dec( 13, 3 ) ) as NoofBags ,
        cast( f.CharcFromDecimalValue as abap.dec( 13, 3 ) )  as  NoOfCones,
        cast( g.CharcFromDecimalValue as abap.dec( 13, 3 ) )  as  PerConesWeight,
        h.CharcValueDescription,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        b.QuantityInBaseUnit  as MadockQty,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        I.PrBagKg    as AvgPrBagWt,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        I.PrConeKg  as AvgPrConeWt,
        K.CustomerName 
}
   where ( b.GoodsMovementType = '501'  or  b.GoodsMovementType = '502' )  and b.GoodsMovementIsCancelled = ' '
