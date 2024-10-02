@AbapCatalog.sqlViewName: 'YPACKINGREP2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Packing Report'
define view ZPACK_HEAD_REP_CDS2 as select distinct from ZPACK_HDR_DEF2 as a 
   left outer join Ymat_STOCK1_SUM2 as b on ( b.Material = a.MaterialNumber 
//   and b.Batch = a.Batch 
                                           and b.Plant = a.Plant and b.StorageLocation = a.RecevingLocation )
   //    left outer join I_DeliveryDocumentItem as c on  ( c.Material = a.MaterialNumber 
     //                                                  and c.Batch = a.RecBatch ) 
      left outer join ZPP_SORTMASTER_CDS as d on ( d.Material = a.MaterialNumber )  
 //     left outer join ZPP_DENIM_FINISH_ENTRY_REP as e on ( a.Batch = e.Peice and a.Setno = e.Setno )
      left outer join  ZDENIM_REPORT_CDS2 as e on (  e.Batch = a.Batch and e.GoodsMovementType = '311' 
                                                       and e.StorageLocation = 'FRC1' and e.Material = a.MaterialNumber and 
                                                       e.GoodsMovementIsCancelled = ' ' )
                                                    
      
      
       
 {     
    key a.Plant,
    key a.PostingDate,
    key a.MaterialNumber,     
    key  a.Batch,  
   // key a.RecBatch,
   // key a.MatDoc,
    //key a.MatDocitem,
    //key a.MatDocyear,
    e.StorageLocation,
    a.RecevingLocation,
    a.OperatorName,
    a.PackGrade,
    a.InspectionMcNo,
    a.ReGrading,
    a.NoOfTp,
    a.Shift,
   // a.FolioNumber,
    a.UnitField,
    a.FinishWidth,
    a.GrossWeight,
    a.NetWeight,
    a.Stdwidth,
    a.cutablewidth ,
    a.Stdnetwt,   
    a.Totalpoint,
    a.Point4,
    a.Remark1,
    a.Remark2,
    a.Stdozs,
    //a.Actozs,
    a.Party,   
    a.Tpremk,
    a.FlagQuantityTotal,
//  sum (a.RollLength )as RollLength,  
    a.RollLength as RollLength,
    a.SalesOrder,
    a.SoItem,
    a.Setno,
    right(             a.Setno, 1            ) as Beam ,
    left(              a.Setno, 7            ) as Setcode ,
    a.Trollyno,
    a.Loomno,
    a.DocumentDate,
    a.Cancelflag,
    d.Dyeingsort, 
  length(a.Batch) as lanth,
   case length(a.Batch)
    when 1     then a.Batch 
    when 2     then a.Batch 
    when 3     then a.Batch 
    when 4     then a.Batch 
    when 5     then a.Batch 
    when 6     then a.Batch 
    when 7     then a.Batch 
    when 8     then a.Batch
      end as batch8,
   
   case  length(a.Batch)
    when 9 then a.Batch
    when 10 then a.Batch
    end as repack,
    
     
  
//   right( a.Batch , 3 )  as REPACK1,
    
   
    case when b.STock is not initial then 'X'
    else '' end as Stock,
  //  case when c.PackingStatus = 'C'  then 'X'
    //else '' end as Delivery,
    

    e.EntryUnit,
//    @Semantics.quantity.unitOfMeasure: 'EntryUnit'
    @DefaultAggregation: #SUM
    e.Quantity    as qty
    
}   

  //where a.Cancelflag = ''  and e.GoodsMovementIsCancelled = '' and e.GoodsMovementType = '311' //and  e.StorageLocation = 'FRC1'
  
 // and ( e.GoodsMovementType = '311' or e.GoodsMovementType = '312' ) 
 // and e.StorageLocation = 'FRC1'

group by 
     a.Plant,
    a.PostingDate,
    a.MaterialNumber,     
     a.Batch,  
  // key a.RecBatch,
  // key a.MatDoc,
   //key a.MatDocitem,
   //key a.MatDocyear,
   e.StorageLocation,
   a.RecevingLocation,
   a.OperatorName,
   a.PackGrade,
   a.InspectionMcNo,
   a.ReGrading,
   a.NoOfTp,
   a.Shift,
  // a.FolioNumber,
   a.UnitField,
   a.FinishWidth,
   a.GrossWeight,
   a.NetWeight,
   a.Stdwidth,
   a.cutablewidth ,
   a.Stdnetwt,   
   a.Totalpoint,
   a.Point4,
   a.Remark1,
   a.Remark2,
   a.Stdozs,
  // a.Actozs,
   a.Party,   
   a.Tpremk,
   a.FlagQuantityTotal,
   a.SalesOrder,
       a.SoItem,
   a.Setno,

   a.Trollyno,
   a.Loomno,
   a.DocumentDate,
   a.Cancelflag,
   d.Dyeingsort ,
   b.STock ,
    
 a.RollLength,
//   c.PackingStatus,
   e.EntryUnit,
   e.Quantity

 
 