@EndUserText.label: 'RESPONCE CDS'
//@EndUserText.label: 'Root'
@Metadata.allowExtensions: true
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZCL_MM_YARN_CONSUMPTION_HTTP'
    }
}

define root custom entity ZMM_YARN_CONSUMPTION_RESPONSE

{
    
      @UI.lineItem   : [{ position: 10 }]
      @UI.selectionField : [{position: 10}]
      @UI.identification: [{position: 10}]
      @EndUserText.label: 'WEFT YARN MATERIAL NAME'
  key material         : abap.char( 40 );
    @UI.lineItem   : [{ position: 20 }]
      @UI.selectionField : [{position: 20}]
      @UI.identification: [{position: 20}]
      @EndUserText.label: 'Plant'
  key plant            : abap.char( 4 );
  
      @UI.lineItem   : [{ position: 20 }]
      @UI.selectionField : [{position: 20}]
      @UI.identification: [{position: 20}]
      @EndUserText.label: 'Customer'
  key Customer            : abap.char( 10 );
  
      @UI.lineItem   : [{ position: 30 }]
      @UI.selectionField : [{position: 30}]
      @UI.identification: [{position: 30}]
      @EndUserText.label: 'From Date'
      from_date        : abap.datn;
      
      @UI.lineItem   : [{ position: 40 }]
      @UI.selectionField : [{position: 40}]
      @UI.identification: [{position: 40}]
      @EndUserText.label: 'To Date'
      to_date          : abap.datn;
      
      @UI.lineItem   : [{ position: 50 }]
      @UI.selectionField : [{position: 50}]
      @UI.identification: [{position: 50}]
      @Semantics.unitOfMeasure: true
      @EndUserText.label: 'UOM'
      materialbaseunit : abap.unit( 3 );
      
      @UI.lineItem   : [{ position: 60 }]
      @UI.selectionField : [{position: 60}]
      @UI.identification: [{position: 60}]
      @EndUserText.label: 'LOT NUMBER'
      LotNumber : abap.char( 10 );
         
      @UI.lineItem   : [{ position: 70 }]
      @UI.selectionField : [{position: 70}]
      @UI.identification: [{position: 70}]
      @EndUserText.label: 'Mill Name'
      Millname :  abap.char( 10 );
      
      @UI.lineItem   : [{ position: 80 }]
      @UI.selectionField : [{position: 80}]
      @UI.identification: [{position: 80}] 
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'Yarn Count'
      YarnCount    : abap.dec( 16, 3 );
      
      @UI.lineItem   : [{ position: 90 }]
      @UI.selectionField : [{position: 90}]
      @UI.identification: [{position: 90}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'Quality Weight'
      QualityWt    : abap.dec( 16, 3 );
      
      @UI.lineItem   : [{ position: 100 }]
      @UI.selectionField : [{position: 100}]
      @UI.identification: [{position: 100}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'QUALITY WT. AS PER COUNT TEST'
      QualityWtCountTest    : abap.dec( 16, 3 );
      
       @UI.lineItem   : [{ position: 110 }]
      @UI.selectionField : [{position: 110}]
      @UI.identification: [{position: 110}]
      @EndUserText.label: 'FABRIC MATERIAL NAME'
      FebricMaterial    : abap.char(40);
      
       @UI.lineItem   : [{ position: 120 }]
      @UI.selectionField : [{position: 120}]
      @UI.identification: [{position: 120}]
      @EndUserText.label: 'PICK ON FABRIC'
      PickOnFabric     : abap.dec(5,2);
      
       @UI.lineItem   : [{ position: 130 }]
      @UI.selectionField : [{position: 130}]
      @UI.identification: [{position: 130}]
      @EndUserText.label: 'REED SPACE'
      REEDSPACE     : abap.dec(7,2);
      
       @UI.lineItem   : [{ position: 140 }]
      @UI.selectionField : [{position: 140}]
      @UI.identification: [{position: 140}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'DISPATCHED QUANTITY (MTR)'
      //         @DefaultAggregation : #SUM
      DisppatchedQty    : abap.dec( 16, 3 );

       @UI.lineItem   : [{ position: 150 }]
      @UI.selectionField : [{position: 150}]
      @UI.identification: [{position: 150}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'YARN OPENING STOCK'
      //         @DefaultAggregation : #SUM
      opening_stock    : abap.dec( 16, 3 );
      
       @UI.lineItem   : [{ position: 160 }]
      @UI.selectionField : [{position: 160}]
      @UI.identification: [{position: 160}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'YARN RECEIVED'
      YARNRECEIVED      : abap.dec( 16, 3 );
      
       @UI.lineItem   : [{ position: 160 }]
      @UI.selectionField : [{position: 160}]
      @UI.identification: [{position: 160}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'YARN RETURN'
      YARNRETURN       : abap.dec( 16, 3 );
      
       @UI.lineItem   : [{ position: 170 }]
      @UI.selectionField : [{position: 170}]
      @UI.identification: [{position: 170}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'CONSUMPTION AS PER BOM '
      CONSUMPTIONASPERBOM   : abap.dec( 16, 3 );
      
       @UI.lineItem   : [{ position: 180 }]
      @UI.selectionField : [{position: 180}]
      @UI.identification: [{position: 180}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'CONSUMPTION AS PER YARN TESTING REPORT'
      CONSUMPTIONASPERYARNTESTING   : abap.dec( 16, 3 );
      
       @UI.lineItem   : [{ position: 190 }]
      @UI.selectionField : [{position: 190}]
      @UI.identification: [{position: 190}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'DIFFERENCE B/W ACTUAL AND COUNT TEST'
      DIFFERENCEBWACTUALANDCOUNTEST         : abap.dec( 16, 3 );
      
       @UI.lineItem   : [{ position: 200 }]
      @UI.selectionField : [{position: 200}]
      @UI.identification: [{position: 200}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'WASTAGE AS PER YARN TESTING REPORT 3.5%'
      WASTAGEASPERYARNTESTING      : abap.dec( 16, 3 );
      
       @UI.lineItem   : [{ position: 210 }]
      @UI.selectionField : [{position: 210}]
      @UI.identification: [{position: 210}]
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'BALANCE YARN'
      BALANCEYARN          : abap.dec( 16, 3 );
       
      @UI.lineItem   : [{ position: 230 }]
      @UI.selectionField : [{position: 230}]
      @UI.identification: [{position: 230}]
      @EndUserText.label: 'ProductDescription'
      ProductDescription        : abap.char( 40 );


}
