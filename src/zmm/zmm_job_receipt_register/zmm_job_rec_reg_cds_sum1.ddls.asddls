@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Receipt Register Report'
define root view entity  ZMM_JOB_REC_REG_CDS_SUM1 as select from
                   I_MaterialDocumentItem_2 as b 
                    left outer join I_BatchDistinct as n on ( n.Batch = b.Batch and n.Material = b.Material )
     
    left outer join ZMM_JOB_REC_REG_INTERNALID_1 as t on ( t.ClassType = '023' and t.ClfnObjectTable = 'MCH1'
                                                               and t.ClfnObjectInternalID = n.ClfnObjectInternalID )               
                    
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as q on 
                                                              ( q.ClassType = '023' and q.ClfnObjectTable = 'MCH1'
                                                               and q.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and q.CharcInternalID =   t.NoOFbags )    // '0000000808' )      // no of bags  
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as s on 
                                                               ( s.ClassType = '023' and s.ClfnObjectTable = 'MCH1'
                                                               and s.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and s.CharcInternalID =  t.Noofcone )  //  '0000000809' )      // no of cones                                               
 
 {
    key b.MaterialDocument,
    key b.MaterialDocumentYear,
        b.Material,
  //      b.MaterialDocumentItem,
        b.MaterialBaseUnit,  
        b.Batch,
        b.Plant,
        b.StorageLocation,
        n.ClfnObjectInternalID,
    
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        case when q.CharcFromDecimalValue is not initial and ( b.GoodsMovementType = '501' or b.GoodsMovementType = '561' )
        then b.QuantityInBaseUnit / cast( q.CharcFromDecimalValue as abap.dec( 13, 3 ) )  
        end as PrBagKg,  
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        case when s.CharcFromDecimalValue is not initial and ( b.GoodsMovementType = '501' or b.GoodsMovementType = '561' ) 
          then b.QuantityInBaseUnit / cast( s.CharcFromDecimalValue as abap.dec( 13, 3 ) ) 
        end as PrConeKg
} 
  where b.StorageLocation = 'YRM1' and b.GoodsMovementIsCancelled = ' '
       and ( b.GoodsMovementType = '501' or b.GoodsMovementType = '561' )