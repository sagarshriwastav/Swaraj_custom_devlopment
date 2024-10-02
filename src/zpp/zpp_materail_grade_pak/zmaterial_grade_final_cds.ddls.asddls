@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMATERIAL_GRADE_FINAL_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMATERIAL_GRADE_FINAL_CDS as select from ZMATERIAL_GRADE_CDS_03 as A
{ 

   @UI.lineItem      : [{position: 10}]
      @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 10}]
      @EndUserText.label:     'Material'
   key  A.material101,
   
   @UI.lineItem      : [{position: 20}]
   //   @UI.selectionField: [{position: 20}]
      @UI.identification: [{position: 20}]
      @EndUserText.label:     'Posting date'
     A.postingdatefini,
     
   
     
      @UI.lineItem      : [{position: 30}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 30}]
      @EndUserText.label:     'UNIT'
     A.zunit,
     
     
      @UI.lineItem      : [{position: 40}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 40}]
      @Semantics.quantity.unitOfMeasure : 'zunit'
      @EndUserText.label:     'Grey Mtr'
     A.greigemtr,
     
      @UI.lineItem      : [{position: 50}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 50}]
       @Semantics.quantity.unitOfMeasure : 'zunit'
      @EndUserText.label:     'Finish mtr'
     A.finishmtr,
     
      @UI.lineItem      : [{position: 60}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 60}]
      @EndUserText.label:     'Fresh'
     A.fresh,
     
      @UI.lineItem      : [{position: 70}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 70}]
      @EndUserText.label:     'SW'
     A.SW,
     
      @UI.lineItem      : [{position: 80}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 80}]
      @EndUserText.label:     'OTH'
     A.OTH,
     
      @UI.lineItem      : [{position: 90}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 90}]
      @EndUserText.label:     'QDS'
     A.QDS,
     
      @UI.lineItem      : [{position: 100}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 100}]
      @EndUserText.label:     'CD'
     A.CD,
     
     
      @UI.lineItem      : [{position: 110}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 110}]
      @EndUserText.label:     'SV'
     A.SV1,
    
      @UI.lineItem      : [{position: 120}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 120}]
      @EndUserText.label:     'SL'
     A.SL,
     
      @UI.lineItem      : [{position: 130}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 130}]
       @Semantics.quantity.unitOfMeasure : 'zunit'
        @Aggregation.default: #SUM
      @EndUserText.label:     'FRC'
     A.qty,
     
      @UI.lineItem      : [{position: 140}]
   //   @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 140}]
      @EndUserText.label:     'roll_length'
     A.roll_length,
     
     cast( coalesce(A.fresh ,0 ) as abap.dec(23,4) ) +  cast( coalesce( A.SW  ,0 ) as abap.dec(23,4) )  + cast( coalesce( A.OTH  ,0 ) as abap.dec(23,4) ) + cast( coalesce( A.QDS  ,0 ) as abap.dec(23,4) )  + cast( coalesce( A.CD  ,0 ) as abap.dec(23,4) )
      + cast( coalesce( A.SV1  ,0 ) as abap.dec(23,4) )  +  cast( coalesce( A.SL  ,0 ) as abap.dec(23,4) )  +  cast( coalesce( A.qty  ,0 ) as abap.dec(23,4) ) +  cast( coalesce( A.RF  ,0 ) as abap.dec(23,4) ) as TOTAL_PACKGRADE,
      
       cast( coalesce(A.fresh ,0 ) as abap.dec(23,4) ) +   cast( coalesce(A.SW ,0 ) as abap.dec(23,4) ) +  cast( coalesce(A.fresh ,0 ) as abap.dec(23,4) ) +  cast( coalesce(A.OTH ,0 ) as abap.dec(23,4) ) + cast( coalesce(A.QDS ,0 ) as abap.dec(23,4) ) as FRESH_MTR,
       
       coalesce( A.CD, 0.00 )  +  coalesce( A.SV1, 0.00 )  + coalesce( A.SL, 0.00 )  + coalesce( A.FRC, 0.00 ) as REJECTION_MTR
    
    
}
