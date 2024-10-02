@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_MATERIAL_PACKING_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_MATERIAL_PACKING_CDS as select from   ZPP_MATERIAL_FRC_CDS   as A
left outer join    ZPP_MATERIAL_PACKHADER as B on (  B.material_number = A.material101 and B.batch = A.finishrollno )//and    )//and B.batch = A.finishrollno  )//a  )//and B.batch = A.finishrollno )//and  B.posting_date = A.postingdate )
left outer  join I_MaterialDocumentItem_2 as C on (  C.Material = B.material_number  and  C.Batch = A.finishrollno )// and C.PostingDate = A.postingdate   ) // and C.PostingDate = A.postingdate )  
  and  ( C.StorageLocation = 'INS1' and C.IssuingOrReceivingStorageLoc = 'FRC1'  and    C.GoodsMovementType = '311'  )   
    

{  key A.material101 as MATERIAL,
   key  A.postingdate,
        A.finishrollno,
  
       A.zunit,
        @Semantics.quantity.unitOfMeasure : 'zunit'
       A.greigemtr as greigemtr ,
        @Semantics.quantity.unitOfMeasure : 'zunit'
       A.finishmtr as  finishmtr,
   //    B.pack_grade,
   //    B.roll_length,
       B.posting_date,
       B.fresh,
       B.QD,
       B.CD,
       B.SV,
       B.SL,
       B.SW,
       B.OTH,
       B.RF,
       B.PD,
       B.FR,
        @Semantics.quantity.unitOfMeasure : 'zunit'
       sum(C.QuantityInBaseUnit) as qty
  
    
        
} 

 group by  A.material101,
           A.postingdate,
            A.zunit,
             A.greigemtr,
              A.finishmtr,
               B.posting_date,     
 B.fresh,            
 B.QD,               
 B.CD,               
 B.SV,               
 B.SL,               
 B.SW,               
 B.OTH,              
 B.RF,               
 B.PD,               
 B.FR ,
 A.finishrollno              
  





































 
/////////////union use select query////////////// 
   
//  union
// 
// select from   ZPP_MATERIAL_FRC_CDS  as A
//left outer join    zpackhdr as B on (  B.material_number = A.material101  and  B.batch = A.finishrollno)//and    )//and B.batch = A.finishrollno  )//a  )//and B.batch = A.finishrollno )//and  B.posting_date = A.postingdate )//  and B.posting_date = A.postingdate  )
//left outer  join I_MaterialDocumentItem_2 as C on (  C.Material = B.material_number  and C.Batch = A.finishrollno   )// and C.PostingDate = A.postingdate   ) // and C.PostingDate = A.postingdate )  
//   and ( C.StorageLocation = 'INS1' and C.IssuingOrReceivingStorageLoc = 'FRC1'   and    C.GoodsMovementType = '311'   ) 
//    
//
//{ 
//  key A.material101 as MATERIAL,
//      
//    
//    
//     A.postingdate as postingdate,
//     
//      cast('M' as abap.unit( 3 ) ) as zunit,
//   //   @Semantics.quantity.unitOfMeasure : 'zunit'
//      sum(A.greigemtr  )as greigemtr ,
//    //   @Semantics.quantity.unitOfMeasure : 'zunit'
//      sum(A.finishmtr ) as finishmtr,
//    //   @Semantics.quantity.unitOfMeasure : 'zunit'
//     sum(C.QuantityInBaseUnit )   as QTY,
//      
//  sum( case when B.pack_grade like 'F1' then (B.roll_length)  end  ) as fresh,
//   sum(case when B.pack_grade  like 'QD' then (B.roll_length) end  )  as QD,
//  sum( case when B.pack_grade like 'CD' then ( B.roll_length ) end ) as CD,
//  sum(case when B.pack_grade like 'SV' then ( B.roll_length ) end ) as SV,
//  sum(case when B.pack_grade like 'SL' then ( B.roll_length ) end)  as SL,
//  sum(case when B.pack_grade like 'SW' then (B.roll_length) end )  as SW,
//  sum(case when B.pack_grade like 'OT' then (B.roll_length) end  ) as OTH,
//  sum(case when B.pack_grade like 'RF' then (B.roll_length) end )  as RF,
//  sum(case when B.pack_grade like 'PD' then (B.roll_length) end )  as PD,
//  sum(case when B.pack_grade like 'FR' then ( B.roll_length )  end ) as FR
//    
//        
//} //where C.GoodsMovementIsCancelled = ' ' 
//  
//group by
//    A.material101,
//    A.postingdate,
// //   A.greigemtr,
// //   A.finishmtr,
//    B.material_number,
//    B.roll_length,
//   B.pack_grade 
  //  C.QuantityInBaseUnit 
   
//  
//    
//  
//  
//  
//  
////    
    
    
    
    
    
    
    
       
 //   sum( case when B.pack_grade like 'F1' then (B.roll_length)  end )  as fresh,
//   sum( case when B.pack_grade  like 'QD' then (B.roll_length) end  )  as QD,
//  sum(case when B.pack_grade like 'CD' then ( B.roll_length ) end ) as CD,
//  sum( case when B.pack_grade like 'SV' then ( B.roll_length ) end ) as SV,
//  sum(case when B.pack_grade like 'SL' then ( B.roll_length ) end  )as SL,
//  sum(case when B.pack_grade like 'SW' then (B.roll_length) end )  as SW,
//  sum(case when B.pack_grade like 'OT' then (B.roll_length) end  ) as OTH,
// sum( case when B.pack_grade like 'RF' then (B.roll_length) end  ) as RF,
//  sum(case when B.pack_grade like 'PD' then (B.roll_length) end  ) as PD,
//  sum(case when B.pack_grade like 'FR' then ( B.roll_length )  end ) as FR
//  
  
//   cast( coalesce(A.fresh ,0 ) as abap.dec(23,2) ) +  cast( coalesce( A.SW  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.OTH  ,0 ) as abap.dec(23,2) ) + cast( coalesce( A.QDS  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.CD  ,0 ) as abap.dec(23,2) )
//      + cast( coalesce( A.SV1  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.SL  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.QTY  ,0 ) as abap.dec(23,2) ) +  cast( coalesce( A.RF  ,0 ) as abap.dec(23,2) ) as TOTAL_PACKGRADE
      
 
// sum( case when A.pack_grade like 'FR' then ( A.roll_length )  end )as FR
  
     
     
     
    
