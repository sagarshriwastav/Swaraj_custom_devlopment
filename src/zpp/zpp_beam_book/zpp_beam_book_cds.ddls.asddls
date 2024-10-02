@EndUserText.label: 'RESPONCE CDS'
//@EndUserText.label: 'Root'
@Metadata.allowExtensions: true
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZPP_BEAM_BOOK_CLASS'
    }
}

define root custom entity ZPP_BEAM_BOOK_CDS

{

      @EndUserText.label: 'Plant'
  key plant            : abap.char( 4 );
  
      @EndUserText.label: 'Beam no'
  key Beam              : abap.char(10);
  
      @EndUserText.label: 'Piece no'
  key Piece_no          : abap.char(10);
  
      @EndUserText.label: 'MATERIAL'
  key material         : abap.char( 40 );
  
      @EndUserText.label: 'Order no.'
      Order_no         : abap.char(12);
  
      @EndUserText.label: 'folding date '
      folding_date     : abap.datn;

      @EndUserText.label: 'Description'
      Description      : abap.char( 40 );
  
      @EndUserText.label: 'Challan Date'
      Challan_Date     : abap.datn;

      @EndUserText.label: 'Pick'
      Pick             : abap.int4;

      @EndUserText.label: 'G. Mtr.'
      G_mtr            : abap.quan(13,3);

 //     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'Weight'
      Weight             : abap.quan(13,3);


  //    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'Wt/Mtr.'
      Wt_Mtr                : abap.quan(13,3);


      @EndUserText.label: 'Challan No.'
      Challan_No          : abap.char( 10 );

      @EndUserText.label: 'Loom No.'
      Loom_No             : abap.numc(3);

 //     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'Beam Length'
      Beam_Length         : abap.dec( 13, 3 );

 //   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'Balance Mtr.'
      Balance_Mtr       : abap.dec( 13, 3 );


      @EndUserText.label: 'Shrinkage %'
      Shrinkage         : abap.dec( 13, 3 );

  //    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      @EndUserText.label: 'Quality Weight'
      QualityWt       : abap.dec(10,3);

      @EndUserText.label: 'Reed'
      Reed             : abap.numc(4);
    
      @EndUserText.label: 'Pick Master'
      MasterPick      : abap.dec(5,2);
       
      @EndUserText.label: 'RS'
      Rs              : abap.dec(7,2);
      
      @EndUserText.label: 'Set Number'
      SetNo        : abap.char(15);
      
      @Semantics.unitOfMeasure: true
      @EndUserText.label: 'UOM'
      materialbaseunit : abap.unit( 3 );



}
