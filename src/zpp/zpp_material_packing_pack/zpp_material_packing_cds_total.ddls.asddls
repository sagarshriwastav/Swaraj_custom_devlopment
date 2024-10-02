@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_MATERIAL_PACKING_CDS_TOTAL'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_MATERIAL_PACKING_CDS_TOTAL
  as select from ZPP_MATERIAL_PACKING_CDS 
{
  key MATERIAL,
  key finishrollno,
      postingdate,
      zunit,
      @Semantics.quantity.unitOfMeasure : 'zunit'
       greigemtr     as greigemtr,
      @Semantics.quantity.unitOfMeasure : 'zunit'
      finishmtr   as finishmtr,
      @Semantics.quantity.unitOfMeasure : 'zunit'
     
     sum(qty)     as QTY,
     sum(fresh ) as fresh,
     sum(QD )     as QDS,
      sum(CD )     as cd,
      sum(SV)      as SV1,
      sum(SL)      as SL,
      sum(SW)      as SW,
      sum(OTH)     as OTH,
      sum(RF)      as RF,
      sum(PD)      as PD,
      sum(FR)      as FR,


      //
           sum( cast( coalesce(fresh ,0 ) as abap.dec(13,2) ) +  cast( coalesce( SW  ,0 ) as abap.dec(13,2) )  + cast( coalesce( OTH  ,0 ) as abap.dec(13,2) ) + cast( coalesce( QD  ,0 ) as abap.dec(13,2) )  + cast( coalesce( CD  ,0 ) as abap.dec(13,2) )
            + cast( coalesce( SV  ,0 ) as abap.dec(13,2) )  +  cast( coalesce( SL  ,0 ) as abap.dec(13,2) )  +  cast( coalesce( qty  ,0 ) as abap.dec(13,2) ) +  cast( coalesce( RF  ,0 ) as abap.dec(13,2) )  + +  cast( coalesce( FR  ,0 ) as abap.dec(13,2) ) )  as TOTAL_PACKGRADE,
//      
      ////
              sum( cast( coalesce(fresh ,0 ) as abap.dec(13,2) ) +   cast( coalesce(SW ,0 ) as abap.dec(13,2) )  +  cast( coalesce(OTH ,0 ) as abap.dec(13,2) ) + cast( coalesce(QD ,0 )  as abap.dec(13,2) ) )  as FRESH_MTR,
      ////
                sum( cast(coalesce( CD, 0.00 )  as abap.dec(13,2) )  +  cast(coalesce( SV, 0.00 )  as   abap.dec(23,2) ) +  cast(coalesce( SL, 0.00 )  as abap.dec(23,2) ) +  cast(coalesce( qty, 0.00 ) as abap.dec(23,2) ) ) as REJECTION_MTR
      ////
}

group by
  MATERIAL,
  postingdate,
  zunit,
finishmtr,
greigemtr,
finishrollno


     
