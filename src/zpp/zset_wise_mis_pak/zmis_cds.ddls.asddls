@EndUserText.label: ' CDS FOR MIS REPORT'
@Metadata.allowExtensions: true
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZMIS_REPORT'
    }
}
define root custom  entity ZMIS_CDS
{



      @UI.lineItem      : [{position: 30}]
         //      @UI.selectionField          : [{position: 40}]
      @UI.identification: [{position: 30}]
      @EndUserText.label:     'FINISH_ROLLNO'
      //     @Aggregation.default: #SUM
      //      @Semantics.quantity.unitOfMeasure : 'zunit'
  key finishrollno      : abap.char(10);
  
  
   @UI.hidden        : true
      @EndUserText.label: 'luom'
 key    luom              : abap.unit(3);
  
  
   @UI.lineItem      : [{position: 20}]
      @UI.selectionField: [{position: 20}]
      @UI.identification: [{position: 20}]
      @EndUserText.label:     'SETPEICENO'
      setpeiceno        : abap.char(10);
   
   
      @UI.lineItem      : [{position: 10}]
      @UI.selectionField: [{position: 10}]
      @UI.identification: [{position: 10}]
      @EndUserText.label:     'SET_NO'
     setno             : abap.char(10);


      @UI.lineItem      : [{position: 40}]
      //     @UI.selectionField          : [{position: 30}]
      @UI.identification: [{position: 40}]
      @EndUserText.label:     'PARTYNAME'
      //    @Aggregation.default: #SUM
      //      @Semantics.quantity.unitOfMeasure : 'zunit'
      partyname         : abap.char(40);

    @UI.lineItem      : [{position: 50}]
      //     @UI.selectionField          : [{position: 30}]
      @UI.identification: [{position: 50}]
      @EndUserText.label:     'ACTUAL_MTR'
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure : 'zunit'
    actualmtr         : abap.quan(13,3);
 

  
      @UI.lineItem      : [{position: 60}]
      //      @UI.selectionField          : [{position: 30}]
      @UI.identification: [{position: 60}]
      @EndUserText.label:     'GREIGE_MTR'
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure : 'zunit'
      greigemtr         : abap.quan(13,3);


      @UI.hidden        : true
      @EndUserText.label: 'zunit'
      zunit             : abap.unit(3);

     

      @UI.lineItem      : [{position: 70}]
      //      @UI.selectionField          : [{position: 30}]
      @UI.identification: [{position: 70}]
      @EndUserText.label:     'FINISH_MTR'
      @Aggregation.default: #SUM
      @Semantics.quantity.unitOfMeasure : 'zunit'
      finishmtr         : abap.quan(13,3);

      @UI.lineItem      : [{position: 80}]
      //      @UI.selectionField          : [{position: 30}]
      @UI.identification: [{position: 80}]
      @EndUserText.label:     'ZORDER'
      zorder            : abap.char(12);
  
      

      @UI.lineItem      : [{position: 90}]
         //      @UI.selectionField          : [{position: 30}]
      @UI.identification: [{position: 90}]
      @EndUserText.label:     'BEAMNO'
      beamno            : abap.char(10);

     @UI.lineItem      : [{position: 100}]
      //     @UI.selectionField          : [{position: 30}]
      @UI.identification: [{position: 100}]
      @EndUserText.label:     'LENGTH'
//   @Aggregation.default: #SUM
    @Aggregation.default: #MAX
      @Semantics.quantity.unitOfMeasure : 'zunit'
     length            : abap.quan(13,3);
  

      @UI.lineItem      : [{position: 101}]
        //     @UI.selectionField          : [{position: 30}]
      @UI.identification: [{position: 101}]
      @EndUserText.label:     'WEAVING_SHRINKAGE'
          @Aggregation.default: #AVG
      @Semantics.quantity.unitOfMeasure : 'zunit'
        weaving_shrinkage :   abap.quan( 13, 2 );
        


      @UI.lineItem      : [{position: 102}]
       //     @UI.selectionField          : [{position: 30}]
      @UI.identification: [{position: 102}]
      @EndUserText.label:     'FINISH_SHRINKAGE'
      @Aggregation.default: #AVG
//      @AnalyticsDetails.query.formula: '(finishmtr / greigemtr ) * 100 '
//      @AnalyticsDetails.query.decimals:2
     @Semantics.quantity.unitOfMeasure : 'zunit'
     finish_shrinkage  : abap.quan( 13, 2 );
      //      FINISH_SHRINKAGE :  abap.char(5);
      
      
      
//       @UI.lineItem      : [{position: 103}]
//      @UI.selectionField          : [{position: 103}]
//      @UI.identification: [{position: 103}]
//      @EndUserText.label:     'lv_total_finishmtr'
//      @Aggregation.default: #SUM
//     @Semantics.quantity.unitOfMeasure : 'zunit'
//      lv_total_finishmtr  : abap.quan( 13, 2 );
//   
//      
//      
//    @UI.lineItem      : [{position: 104}]
//            @UI.selectionField          : [{position: 30}]
//      @UI.identification: [{position: 104}]
//      @EndUserText.label:     'lv_total_actualmtr'
//      @Aggregation.default: #SUM
//    @Semantics.quantity.unitOfMeasure : 'zunit'
//          lv_total_actualmtr  : abap.quan( 13, 2 );
//      
//      
/////      @UI.lineItem      : [{position: 105}]
//       //     @UI.selectionField          : [{position: 30}]
/////      @UI.identification: [{position: 105}]
/////     @EndUserText.label:     ' lv_total_length'
/////      @Aggregation.default: #SUM
/////     @Semantics.quantity.unitOfMeasure : 'zunit'
/////      lv_total_length  : abap.quan( 13, 2 );
//      
//     @UI.lineItem      : [{position: 106}]
//     @UI.selectionField          : [{position: 30}]
//      @UI.identification: [{position: 106}]
//     @EndUserText.label:     'lv_total_finish_shrinkage'
//      @Aggregation.default: #SUM
//    @Semantics.quantity.unitOfMeasure : 'zunit'
//      lv_total_finish_shrinkage  : abap.quan( 13, 2 );
//      
//      
//      @UI.lineItem      : [{position: 107}]
//            @UI.selectionField          : [{position: 30}]
//      @UI.identification: [{position: 107}]
//   @EndUserText.label:     'lv_total_weaving_shrinkage'
//      @Aggregation.default: #SUM
//     @Semantics.quantity.unitOfMeasure : 'zunit'
//      lv_total_weaving_shrinkage  : abap.quan( 13, 2 );
//      
      
      
      
      
      
      
      
      
   






}
