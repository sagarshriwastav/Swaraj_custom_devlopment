@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPRODUCTION_SUMMARY_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view entity ZPRODUCTION_SUMMARY_CDS as select from ZMIS_REPORT_QUANTITY
{
   key PostingDate,
   key Batch,
       luom,
       @Semantics.quantity.unitOfMeasure : 'luom'
       Length as  Dyeingproduction,
       MaterialBaseUnit as MaterialBaseUnit4,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit4'
       WarpingLength1 as Warpingproduction,
       cast( 'M' as abap.unit( 3 ))  as Zunit,
       @Semantics.quantity.unitOfMeasure : 'zunit'
       QuantityInBaseUnit as Greyproduction,
       Zunit3,
       @Semantics.quantity.unitOfMeasure : 'zunit3'
       Finishmtr1 as Finishingproduction,
       CD1,
       SV2,
       SL1,
       F2,
       SW1,
       OTH1,
       PDS1,
       QDS1,
       FR1,
     //  ( 22 / 60 ) as abc,
       ( Length / 22 / 60 ) as AvgPerMinuteDyeing,
       ( ( coalesce( CD1 ,0 ) ) + ( coalesce( SV2 ,0 ) )  + ( coalesce( SL1 ,0 ) ) + ( coalesce( F2 ,0 ) ) + ( coalesce( SW1 ,0 ) ) + ( coalesce( OTH1 ,0 ) ) + ( coalesce( PDS1 ,0 ) ) + ( coalesce( QDS1 ,0 ) ) + ( coalesce( FR1 ,0 ) )  ) as GradingProduction
       
       
   
}
