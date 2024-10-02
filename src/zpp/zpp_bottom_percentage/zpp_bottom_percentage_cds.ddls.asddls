@AbapCatalog.sqlViewName: 'YBOTTOM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BOTTOM_PERCENTAGE_CDS'
define view ZPP_BOTTOM_PERCENTAGE_CDS as select from  I_MfgOrderDocdGoodsMovement as A
                   inner join I_MaterialDocumentItem_2 as b  on (  b.OrderID = A.ManufacturingOrder 
                                       and b.GoodsMovementType = '101' and b.GoodsMovementIsCancelled = '' and b.Material = A.Material 
                                       and b.MaterialDocumentItem = A.GoodsMovementItem
                                       and b.MaterialDocument = A.GoodsMovement  and  A.GoodsMovementType = '101' and A.Material like 'BW%' )
                    left outer join ZPP_BOTTOM_PERCENTAGE_261 as C on ( C.Batch = A.Batch and C.OrderID = A.ManufacturingOrder  )                   
                    left outer join ZPP_BOTTOM__261_YGPPV as d on ( d.Batch = A.Batch and d.OrderID = A.ManufacturingOrder )                   
                    left outer join ZPP_BOTTOM__531_532 as e on ( e.orderid = A.ManufacturingOrder )                   
     
     left outer join  ZPP_WARPING_AVGBPM as f on ( f.ZfsetNo = A.Batch )
     
     left outer join I_BatchDistinct as n on ( n.Batch = A.Batch and n.Material = C.Cotton_Yarn )
     
     left outer join ZPP_BOTTOM_PERCENTAGE_311 as g on ( g.Batch = A.Batch and g.Material = C.Cotton_Yarn )
     
     
     left outer join ZMM_JOB_REC_REG_INTERNALID_1 as u on ( u.ClassType = '023' and u.ClfnObjectTable = 'MCH1'
                                                               and u.ClfnObjectInternalID = n.ClfnObjectInternalID )
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as o on ( o.ClassType = '023' and o.ClfnObjectTable = 'MCH1'
                                                               and o.ClfnObjectInternalID = u.ClfnObjectInternalID
                                                               and o.CharcInternalID = u.Lotnumber ) // '0000000807' ) // lotnumber
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as p on ( p.ClassType = '023' and p.ClfnObjectTable = 'MCH1'
                                                               and p.ClfnObjectInternalID = u.ClfnObjectInternalID
                                                               and p.CharcInternalID = u.Milname ) // '0000000806' ) // millname
     
     left outer join ZI_ClfnCharcValueDesc_cds as t on ( t.mil = p.CharcValue and t.CharcInternalID = u.Milname and  // '0000000806' and 
                                                  t.Language = 'E' )
     left outer join  ZPP_MCARDR_CDS1 as i on ( i.dyesort = f.Material  )
     left outer join ZPP_CONSUME_YARN_CDS as j on ( j.Batch = A.Batch )
     left outer join ZPP_CONSUME_YARN_C as k on ( k.Batch = A.Batch )
               
{
    key A.SalesOrder ,
    key A.SalesOrderItem , 
    key A.Material as Warping_Short  ,  
    key A.ManufacturingOrder as orderid ,
    key A.Batch ,
        A.PostingDate ,
      cast( 'KG' as abap.unit( 3 ) ) as zunit,

        b.MaterialBaseUnit ,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
        A.QuantityInBaseUnit as Warping_Length,
//        A.PostingDate,
        A.BaseUnit ,
        @Semantics.quantity.unitOfMeasure: 'zunit'
        C.Cotton_Yarn ,
        @Semantics.quantity.unitOfMeasure: 'zunit'
        C.Issue_Cotton_Yarn,
        d.PV_Yarn,
        d.Issue_PV_Yarn,     
        e.Bottom_Sort,      
        e.Bottom,
        count(distinct A.Batch )  as BreaksmtrCountr,
        f.avgbpmm , 
        f.beamin1creel ,
        f.supplierconweight ,
        @Semantics.quantity.unitOfMeasure: 'zunit'
        f.Zcount,
        f.Material as Dying_Short,
        n.ClfnObjectInternalID,
        o.CharcValue as Cotton_Yarn_Lotno,
        t.CharcValueDescription as Cotton_Yarn_Mill_Name,      
        g.MaterialDocumentHeaderText as Cotton_Yarn_PartyBill,
         @Semantics.quantity.unitOfMeasure: 'zunit'
        i.zptotends ,
        i.bodyends ,
        i.pvends,
//        j.NEWConsumeYarn,
//        j.NEWConsumeYarn1,
              
        @Semantics.quantity.unitOfMeasure: 'zunit'     
        cast( f.Zcount as abap.dec( 13, 3 ) )  as dividecount,
        
   //     j.ConsumeYarn,
   //     j.ConsumeYarn2,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'
        case when k.zptotends <= 8990 then k.dec1_10_0  when k.zptotends > 8990 
        then k.dec1_10_01 end as Consume,
        cast('M' as abap.char( 5) ) as  zunit1,
        @Semantics.quantity.unitOfMeasure: 'zunit1'
       k.ConsumeYarn1 ,
       j.NEWConsumeYarn,
       j.NEWConsumeYarn1,
       j.zptotends24,
       j.zptotends32,
       i.COMPARE ,
       
       
 case when i.COMPARE = 1 then j.NEWConsumeYarn else j.NEWConsumeYarn1  end as consume_yarn  

//    case when  ( j.zptotends -  24  )  <= 8990  then j.NEWConsumeYarn   when  (j.zptotends - 32  ) > 8990    then j.NEWConsumeYarn1  end as consume_yarn , 
   
//       
//    
    
    
    
    
    
 //       k.dec1_10_0,
 //       k.dec1_10_01
//        
//        
      
    
       
   
}   where A.GoodsMovementType = '101' and A.Material like 'BW%' 
    

//where  A.GoodsMovementType = '101'
// or A.Material like 'YGPCO%   

 group by 
 
     A.SalesOrder ,
     A.SalesOrderItem , 
     A.Material  ,  
     A.ManufacturingOrder  ,
     A.Batch ,
     A.PostingDate ,
     b.MaterialBaseUnit ,
     A.QuantityInBaseUnit,
     A.BaseUnit ,
     C.Cotton_Yarn ,
     C.Issue_Cotton_Yarn,
     d.PV_Yarn,
     d.Issue_PV_Yarn,
     e.Bottom_Sort,
     e.Bottom,
     f.Zcount,
     f.avgbpmm ,
     f.beamin1creel ,
     f.supplierconweight ,
     f.Material ,
     n.ClfnObjectInternalID,
     o.CharcValue ,
     t.CharcValueDescription ,
     g.MaterialDocumentHeaderText ,
     i.zptotends,
     i.COMPARE ,
     i.bodyends ,
     i.pvends,
//     j.ConsumeYarn,
     k.ConsumeYarn1,
 //    j.zptotends,
     k.dec1_10_0,
     k.dec1_10_01,
     k.zptotends,
      j.NEWConsumeYarn,
       j.NEWConsumeYarn1,
        k.zptotends,
        j.zptotends,
        j.zptotends24,
        j.zptotends32
      

 
