@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR MATERIAL_GRADE_03'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMATERIAL_GRADE_CDS_03
  as select from    ZMATERIAL_GRADE_CDS    as A
    left outer join ZMATERIAL_GRADE_CDS_02 as B on(
    //  B.Material    = A.material101 
       B.material_number = A.material101 )//and B.plant = A.plant and B.posting_date = A.postingdatefini)
    
{
  key A.material101,
      ///      A.materialdocument101,
      //      B.material_number,
      A.zunit,
      @Semantics.quantity.unitOfMeasure : 'zunit'
      A.finishmtr,
      @Semantics.quantity.unitOfMeasure : 'zunit'
      A.greigemtr,
      A.shrinkageperc,
      B.pack_grade,
      B.posting_date,
      B.roll_length,
      A.MaterialBaseUnit,
      A.postingdatefini,
      cast ( B.posting_date as abap.char( 10 )  )          as postingdate1,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     sum(A.QTY ) as qty ,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    // cast( A.QTY as abap.dec(13,0) ) as QTY,     
       sum(B.fresh)                                        as fresh,
      sum(B.QD)                                            as QDS,
      sum(B.CD)                                            as CD,
      sum(B.SV)                                            as SV1,
      sum(B.SL)                                            as SL,
      sum(B.SW)                                            as SW,
      sum(B.OTH)                                           as OTH,
      sum(B.RF)                                            as RF,
      sum(B.PD)                                            as PDS,
      sum(B.FRC)                                           as FRC,
      sum(B.FRC)                                           as FRCC
//      
//           cast    ( B.fresh as abap.dec(13,1) ) as fresh,
//           cast ( B.QD as abap.dec(13,1) ) as QDS,
//           cast ( B.CD as abap.dec(13,1) ) as CD,
//           cast ( B.SV as abap.dec(13,1) ) as SV1,
//           cast ( B.SL as abap.dec(13,1) ) as SL,
//           cast ( B.SW as abap.dec(13,1) ) as SW,
//           cast ( B.OTH as abap.dec(13,1) ) as OTH,
//           cast ( B.RF as abap.dec(13,1) ) as RF,
//           cast ( B.PD as abap.dec(13,1) ) as PDS,
//           cast ( B.FRC as abap.dec(13,1) ) as FRC,
//           cast ( B.FRC as abap.dec(13,1) ) as FRCC
           
//      sum(B.FRC+B.QD+B.CD+B.SV+B.SL+B.SW+B.OTH+B.RF+B.FRC) as TOTAL_PACKGRADE



}
group by
  A.material101,
  A.zunit,
  A.finishmtr,
  A.shrinkageperc,
  B.pack_grade,
  B.posting_date,
  B.FRC,
  B.roll_length,
  A.greigemtr,
//  B.fresh,
//  B.QD,
//  B.CD,
//  B.SV,
//  B.SL,
//  B.SW,
//  B.OTH,
//  B.RF,
//  B.PD,
//  B.FRC,
 //A.QTY,
  A.MaterialBaseUnit,
  A.postingdatefini
//  
// 
  
//      A.materialdocument101,
//      B.material_number
