//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'DENIM  PACKING REPORT'

@EndUserText.label: 'Root CDS for Product via RFC'
@Metadata.allowExtensions: true
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZPP_PACK_REP_CL'
    }
}


define root custom entity ZPP_PACK_REP_CDS 

{
  @UI.identification: [ {
    position: 10 , 
    label: 'Plant1'
  } ]
  @UI.lineItem: [ {
    position: 10 , 
    label: 'Plant1'
  } ]    
      @UI.selectionField : [{position: 10}] 
 key  plant          : abap.char( 4 );
      @UI.lineItem   : [{ position: 20 }]
      @UI.identification: [{  position: 20 , 
    label: 'PostingDate' }]
      @UI.selectionField : [{position: 20}]
      
 key posting_date           :abap.sstring( 100 ) ;  
      @UI.lineItem   : [{ position: 30 }]
      @UI.selectionField : [{position: 30}]
      @UI.identification: [{position: 30}]
 key material_number           :abap.char( 18 ) ;  
      @UI.lineItem   : [{ position: 40 }]
      @UI.selectionField : [{position: 40}]
      @UI.identification: [{position: 40}]
 key  PRODUCTDESCRIPTION      : abap.char( 40 ) ;  
      @UI.lineItem   : [{ position: 50 }]
      @UI.selectionField : [{position: 50}]
      @UI.identification: [{position: 50}]
 key  rec_batch      : abap.char( 10 ) ;  
      @UI.lineItem   : [{ position: 60 }]
      @UI.selectionField : [{position: 60}]
      @UI.identification: [{position: 60}]
 key  batch          : abap.char( 10 );
      @UI.lineItem   : [{ position: 70 }]
      @UI.selectionField : [{position: 70}]
      @UI.identification: [{position: 70}]
 key  ftype          :abap.sstring( 100 ) ;
      @UI.lineItem   : [{ position: 70 }]
      @UI.selectionField : [{position: 70}]
      @UI.identification: [{position: 70}]
 key  mat_doc          :abap.char( 10 ) ;
       @UI.lineItem   : [{ position: 80 }]
      @UI.selectionField : [{position: 80}]
      @UI.identification: [{position: 80}]
 key  storage_location          :abap.char( 4 ) ;
       @UI.lineItem   : [{ position: 90 }]
      @UI.selectionField : [{position: 90}]
      @UI.identification: [{position: 90}]
 key  receving_location          :abap.char( 4 ) ;
       @UI.lineItem   : [{ position: 100 }]
      @UI.selectionField : [{position: 100}]
      @UI.identification: [{position: 100}]
 key  operator_name          :abap.sstring( 100 ) ;
       @UI.lineItem   : [{ position: 110 }]
      @UI.selectionField : [{position: 110}]
      @UI.identification: [{position: 110}]
 key  pack_grade          :abap.char( 2 ) ;
       @UI.lineItem   : [{ position: 120 }]
      @UI.selectionField : [{position: 120}]
      @UI.identification: [{position: 120}]
 key  finish_width          :abap.dec(13,0);
       @UI.lineItem   : [{ position: 130 }]
      @UI.selectionField : [{position: 130}]
      @UI.identification: [{position: 130}]
 key  no_of_tp          :abap.sstring( 100 ) ;
       @UI.lineItem   : [{ position: 140 }]
      @UI.selectionField : [{position: 140}]
      @UI.identification: [{position: 140}]
 key  shift          :abap.char( 1 ) ;
       @UI.lineItem   : [{ position: 150 }]
      @UI.selectionField : [{position: 150}]
      @UI.identification: [{position: 150}]
 key  folio_number          :abap.char( 10 ) ;
       @UI.lineItem   : [{ position: 160 }]
      @UI.selectionField : [{position: 160}]
      @UI.identification: [{position: 160}]
 key  net_weight          :abap.dec(13,0) ;
       @UI.lineItem   : [{ position: 170 }]
      @UI.selectionField : [{position: 170}]
      @UI.identification: [{position: 170}]
 key  gross_weight          :abap.dec(13,0) ;
      @UI.selectionField : [{position: 180}]
       @UI.lineItem   : [{ position: 180 }]
      @UI.identification: [{position: 180}]
 key  roll_length          :abap.dec(13,0) ;
       @UI.selectionField : [{position: 190}]
       @UI.lineItem   : [{ position: 190 }]
      @UI.identification: [{position: 190}]
 key  sales_order          :abap.char( 12 ) ;
       @UI.selectionField : [{position: 200}]
       @UI.lineItem   : [{ position: 200 }]
      @UI.identification: [{position: 200}]
 key  so_item          :abap.char( 4 ) ;
       @UI.selectionField : [{position: 210}]
       @UI.lineItem   : [{ position: 210 }]
      @UI.identification: [{position: 210}]
 key  remark1          :abap.sstring( 100 ) ;
       @UI.selectionField : [{position: 220}]
       @UI.lineItem   : [{ position: 220 }]
      @UI.identification: [{position: 220}]
 key  remark2          :abap.sstring( 100 ) ;
      
}
