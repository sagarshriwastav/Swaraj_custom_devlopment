@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PACKING FINAL CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_MATERIAL_PACKING_FINAL_CDS
  as select distinct from ZPP_MATERIAL_PACKING_CDS_TOTAL as A
{



         @UI.lineItem      : [{position: 10}]
         @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 10}]
         @EndUserText.label:     'Material'
  key    A.MATERIAL,



         //   @UI.lineItem      : [{position: 30}]
         //   //   @UI.selectionField: [{position: 10}]
         //      @UI.identification: [{position: 30}]
         //  //    @Semantics.quantity.unitOfMeasure : 'zunit'
         //      @EndUserText.label:     'pack_grade'
         //   key A.pack_grade,
         //


         @UI.lineItem      : [{position: 20}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 20}]
         @EndUserText.label:     'UNIT'
  key    A.zunit,

         //
         @UI.lineItem      : [{position: 30}]
         @UI.selectionField: [{position: 30}]
         @UI.identification: [{position: 30}]
         @EndUserText.label:     'Posting date'
  key    A.postingdate,
         ////

         @UI.lineItem      : [{position: 40}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 40}]
         @Semantics.quantity.unitOfMeasure : 'zunit'
         @EndUserText.label:     'Grey Mtr'
         @Aggregation.default: #SUM
  key    A.greigemtr,

         @UI.lineItem      : [{position: 50}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 50}]
         @Semantics.quantity.unitOfMeasure : 'zunit'
         @EndUserText.label:     'Finish mtr'
         @Aggregation.default: #SUM
  key    A.finishmtr,

         @UI.lineItem      : [{position: 60}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 60}]
         @EndUserText.label:     'Fresh'
         @Aggregation.default: #SUM
  key    A.fresh,

         @UI.lineItem      : [{position: 70}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 70}]
         @EndUserText.label:     'SW'
             @Aggregation.default: #SUM
  key    A.SW,

         @UI.lineItem      : [{position: 80}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 80}]
         @EndUserText.label:     'OTH'
            @Aggregation.default: #SUM
  key    A.OTH,

         @UI.lineItem      : [{position: 90}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 90}]
         @EndUserText.label:     'QDS'
            @Aggregation.default: #SUM
  key    A.QDS,

         @UI.lineItem      : [{position: 100}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 100}]
         @EndUserText.label:     'CD'
           @Aggregation.default: #SUM
  key    A.cd,


         @UI.lineItem      : [{position: 110}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 110}]
         @EndUserText.label:     'SV'
             @Aggregation.default: #SUM
  key    A.SV1,

         @UI.lineItem      : [{position: 120}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 120}]
         @EndUserText.label:     'SL'
           @Aggregation.default: #SUM
  key    A.SL,

         @UI.lineItem      : [{position: 130}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 130}]
         @Semantics.quantity.unitOfMeasure : 'zunit'
         @Aggregation.default: #SUM
         @EndUserText.label:     'FRC'
  key    A.QTY,

         @UI.lineItem      : [{position: 140}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 140}]
         @Semantics.quantity.unitOfMeasure : 'zunit'
          @Aggregation.default: #SUM
         @EndUserText.label:     'FR'
  key    A.FR,



         @UI.lineItem      : [{position: 150}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 150}]
         @EndUserText.label:     'TOTAL_PACKGRADE'
         @Aggregation.default: #SUM
         key    A.TOTAL_PACKGRADE,
//         cast( coalesce(A.fresh ,0 ) as abap.dec(23,2) ) +  cast( coalesce( A.SW  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.OTH  ,0 ) as abap.dec(23,2) ) + cast( coalesce( A.QDS  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.cd  ,0 ) as abap.dec(23,2) )
//          + cast( coalesce( A.SV1  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.SL  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.RF  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.QTY  ,0 ) as abap.dec(23,2) )   +  cast( coalesce( A.FR  ,0 ) as abap.dec(23,2) )                                         as TOTAL_PACKGRADE,
         // +  cast( coalesce( A.QTY  ,0 ) as abap.dec(23,2) )

         @UI.lineItem      : [{position: 160}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 160}]
         @EndUserText.label:     'FRESH_MTR'
         @Aggregation.default: #SUM
          key A.FRESH_MTR,
//           cast( coalesce(A.SW ,0 ) as abap.dec(23,2) ) +  cast( coalesce(A.fresh ,0 ) as abap.dec(23,2) ) +  cast( coalesce(A.OTH ,0 ) as abap.dec(23,2) ) + cast( coalesce(A.QDS ,0 ) as abap.dec(23,2) ) as FRESH_MTR,



         @UI.lineItem      : [{position: 170}]
         //   @UI.selectionField: [{position: 10}]
         @UI.identification: [{position: 170}]
         @EndUserText.label:     'REJECTION_MTR'
         @Aggregation.default: #SUM
          key      A.REJECTION_MTR,
          
          
  //         @UI.lineItem      : [{position: 210}]
         //   @UI.selectionField: [{position: 10}]
      //   @UI.identification: [{position: 210}]
//         @Semantics.quantity.unitOfMeasure : 'zunit'
       //   @Aggregation.default: #SUM
         @EndUserText.label:     'BATCH'
  key    A.finishrollno,
         
//         cast(coalesce( A.cd, 0.00 )  as abap.dec(23,2) )  +  cast(coalesce( A.SV1, 0.00 )  as   abap.dec(23,2) ) +  cast(coalesce( A.SL, 0.00 )  as abap.dec(23,2) )   +  cast(coalesce( A.QTY, 0.00 ) as abap.dec(23,2) )                                   as REJECTION_MTR
         
          @UI.lineItem      : [{position: 180}]
////   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 180}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'FRESH%'
//     //  cast( coalesce(A.FRESH_MTR ,0 ) as abap.fltp ) /  cast( coalesce(A.TOTAL_PACKGRADE ,0 ) as abap.fltp )  as FRE,
     case when TOTAL_PACKGRADE > 0
// //    then    cast(cast( A.finishmtr as abap.decfloat16 ) / cast( A.TOTAL_PACKGRADE as abap.decfloat16 ) as abap.decfloat16 ) end as freshf,
         then    cast(cast( A.FRESH_MTR as abap.dec( 26, 2 ) ) / cast( A.TOTAL_PACKGRADE as abap.dec( 26, 2 ) ) * 100 as abap.dec( 13, 2 ) )  end as freshf,
         
         @UI.lineItem      : [{position: 190}]
////   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 190}]
      @Aggregation.default: #SUM
      @EndUserText.label:     'REJECTION%'
//
      case when TOTAL_PACKGRADE > 0
  //   then  cast( coalesce(A.REJECTION_MTR ,0 ) as abap.dec( 13, 2) ) /  cast( coalesce(A.TOTAL_PACKGRADE ,0 ) as abap.dec( 13, 2 ) ) end  as REJECTION
               then    cast(cast( A.REJECTION_MTR as abap.dec( 13, 2 ) ) / cast( A.TOTAL_PACKGRADE as abap.dec( 13, 2 ) )  * 100 as abap.dec( 13, 2 ) )  end as REJECTION,
      
//
//
/////////     
           @UI.lineItem      : [{position: 200}]
//////////   //   @UI.selectionField: [{position: 10}]
     @UI.identification: [{position: 200}]
     @EndUserText.label:     'SHRINKAGE%'
     @Aggregation.default: #SUM
   //  cast(coalesce(100 - A.finishmtr ) AS ABAP.dec( 13, 3 ))  /   cast(coalesce( A.greigemtr  AS ABAP.dec( 13, 3 ))    as  SHRINKAGE
//////    //  cast(cast( 100-  A.finishmtr as abap.dec( 13, 2 ) ) / cast( A.greigemtr as abap.dec( 13, 2 ) ) as abap.dec( 13, 2 ) )  as shrinkage
//        CAST(COALESCE(100 - A.finishmtr, 0) AS DECIMAL(13, 3)) / CAST(COALESCE(A.greigemtr, 0) AS DECIMAL(13, 3)) AS SHRINKAGE
          cast( cast(100 as abap.dec( 15, 2 ) )  -
              ( cast(A.finishmtr as abap.dec( 15, 2 ) )  / 
                cast( A.greigemtr as abap.dec( 15, 2 ) ) * 100  )  as abap.dec( 15, 2 ) ) as shrinkage
         
         
         
         

}

 

































// @UI.lineItem      : [{position: 150}]
//////   //   @UI.selectionField: [{position: 10}]
//      @UI.identification: [{position: 150}]
//      @EndUserText.label:     'TOTAL_PACKGRADE'
//     A.TOTAL_PACKGRADE,
//
//
//     @UI.lineItem      : [{position: 160}]
//////   //   @UI.selectionField: [{position: 10}]
//      @UI.identification: [{position: 160}]
//      @EndUserText.label:     'FRESH_MTR'
//     A.FRESH_MTR,
//
//     @UI.lineItem      : [{position: 170}]
//////   //   @UI.selectionField: [{position: 10}]
//      @UI.identification: [{position: 170}]
//      @EndUserText.label:     'REJECTION_MTR'
//     A.REJECTION_MTR


//      @UI.lineItem      : [{position: 180}]
////   //   @UI.selectionField: [{position: 10}]
//      @UI.identification: [{position: 180}]
//      @EndUserText.label:     'FRESH%'
//     //  cast( coalesce(A.FRESH_MTR ,0 ) as abap.fltp ) /  cast( coalesce(A.TOTAL_PACKGRADE ,0 ) as abap.fltp )  as FRE,
//     case when TOTAL_PACKGRADE > 0
// //    then    cast(cast( A.finishmtr as abap.decfloat16 ) / cast( A.TOTAL_PACKGRADE as abap.decfloat16 ) as abap.decfloat16 ) end as freshf,
//         then    cast(cast( A.finishmtr as abap.dec( 13, 2 ) ) / cast( A.TOTAL_PACKGRADE as abap.dec( 13, 2 ) ) as abap.dec( 13, 2 ) ) end as freshf
//
////
//////
//      @UI.lineItem      : [{position: 190}]
////   //   @UI.selectionField: [{position: 10}]
//      @UI.identification: [{position: 190}]
//      @EndUserText.label:     'REJECTION%'
//
//      case when TOTAL_PACKGRADE > 0
//     then  cast( coalesce(A.REJECTION_MTR ,0 ) as abap.dec( 13, 2) ) /  cast( coalesce(A.TOTAL_PACKGRADE ,0 ) as abap.dec( 13, 2 ) ) end  as REJECTION
//



//        @UI.lineItem      : [{position: 210}]
////   //   @UI.selectionField: [{position: 10}]
//      @UI.identification: [{position: 210}]
//      @EndUserText.label:     'SHRINKAGE%'
//       cast( coalesce(  100 - A.finishmtr ,0 ) as abap.dec(23,2) ) /  cast( coalesce(A.greigemtr ,0 ) as abap.dec(23,2) )  as  SHRINKAGE
//
//



// @UI.lineItem      : [{position: 180}]
//         //   @UI.selectionField: [{position: 10}]
//         @UI.identification: [{position: 180}]
//         @EndUserText.label:     'FRESH%'
//     //    @Aggregation.default: #SUM
//         // key A.FRESH_MTR,
//         case when  cast( coalesce(A.fresh ,0 ) as abap.dec(23,2) ) +  cast( coalesce( A.SW  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.OTH  ,0 ) as abap.dec(23,2) ) + cast( coalesce( A.QDS  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.cd  ,0 ) as abap.dec(23,2) )
//          + cast( coalesce( A.SV1  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.SL  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.RF  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.QTY  ,0 ) as abap.dec(23,2) )   +  cast( coalesce( A.FR  ,0 ) as abap.dec(23,2) )    > 0
//           
//        then  cast( coalesce(A.SW ,0 ) as abap.dec(23,2) ) +  cast( coalesce(A.fresh ,0 ) as abap.dec(23,2) ) +  cast( coalesce(A.OTH ,0 ) as abap.dec(23,2) ) + cast( coalesce(A.QDS ,0 ) as abap.dec(23,2) ) /    cast( coalesce(A.fresh ,0 ) as abap.dec(23,2) ) +  cast( coalesce( A.SW  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.OTH  ,0 ) as abap.dec(23,2) ) + cast( coalesce( A.QDS  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.cd  ,0 ) as abap.dec(23,2) )
//          + cast( coalesce( A.SV1  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.SL  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.RF  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.QTY  ,0 ) as abap.dec(23,2) )   +  cast( coalesce( A.FR  ,0 ) as abap.dec(23,2) )                                   end       as freshh,
//         
//         
//
//
//            @UI.lineItem      : [{position: 190}]
//         //   @UI.selectionField: [{position: 10}]
//         @UI.identification: [{position: 190}]
//         @EndUserText.label:     'REJECTED%'
//     //    @Aggregation.default: #SUM
//         // key A.FRESH_MTR,
//         
//          case when  cast( coalesce(A.fresh ,0 ) as abap.dec(23,2) ) +  cast( coalesce( A.SW  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.OTH  ,0 ) as abap.dec(23,2) ) + cast( coalesce( A.QDS  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.cd  ,0 ) as abap.dec(23,2) )
//          + cast( coalesce( A.SV1  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.SL  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.RF  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.QTY  ,0 ) as abap.dec(23,2) )   +  cast( coalesce( A.FR  ,0 ) as abap.dec(23,2) )    > 0
//         
//         
//       then cast(coalesce( A.cd, 0.00 )  as abap.dec(23,2) )  +  cast(coalesce( A.SV1, 0.00 )  as   abap.dec(23,2) ) +  cast(coalesce( A.SL, 0.00 )  as abap.dec(23,2) )   +  cast(coalesce( A.QTY, 0.00 ) as abap.dec(23,2) )                                /    cast( coalesce(A.fresh ,0 ) as abap.dec(23,2) ) +  cast( coalesce( A.SW  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.OTH  ,0 ) as abap.dec(23,2) ) + cast( coalesce( A.QDS  ,0 ) as abap.dec(23,2) )  + cast( coalesce( A.cd  ,0 ) as abap.dec(23,2) )
//          + cast( coalesce( A.SV1  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.SL  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.RF  ,0 ) as abap.dec(23,2) )  +  cast( coalesce( A.QTY  ,0 ) as abap.dec(23,2) )   +  cast( coalesce( A.FR  ,0 ) as abap.dec(23,2) )                                end          as rejectedmtrr
//         
//         //    +  cast(coalesce( A.QTY, 0.00 ) as abap.dec(23,2) )
//         
//         
//        

//       cast( ZPP_FF_STOCK_CDS1.totalpoint as ABAP.FLTP ) * 36 * 100 / cast( ZPP_FF_STOCK_CDS1.CurrentStock as ABAP.FLTP ) * cast( ZPP_FF_STOCK_CDS1.finish_width as ABAP.FLTP )
