@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR MATERIAL_GRADE_CDS_02'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMATERIAL_GRADE_CDS_02
  as select from    zpackhdr          as A
  left outer join ZMATERIAL_GRADE_CDS as B on ( B.material101  = A.material_number  )// and B.plant = A.plant   and A.posting_date = B.postingdatefini)
   
  
//    left outer join I_MaterialStock_2 as B on(
//      B.Material = A.material_number 
//    )
    
//    left outer join ZMATERIAL_GRADE_CDS as BB on ( BB.material101 = A.material_number   )
     
{
 key A.material_number,
  A.pack_grade,
  A.posting_date,
  A.plant,
  A.roll_length,
  B.material101,
   B.MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  B.QTY as qty,
  case when A.pack_grade like 'F1' then (A.roll_length) end   as fresh,
  case when A.pack_grade like 'QD' then (A.roll_length) end   as QD,
  case when A.pack_grade like 'CD' then ( A.roll_length ) end as CD,
  case when A.pack_grade like 'SV' then ( A.roll_length ) end as SV,
  case when A.pack_grade like 'SL' then ( A.roll_length ) end as SL,
  case when A.pack_grade like 'SW' then (A.roll_length) end   as SW,
  case when A.pack_grade like 'OT' then (A.roll_length) end   as OTH,
  case when A.pack_grade like 'RF' then (A.roll_length) end   as RF,
  case when A.pack_grade like 'PD' then (A.roll_length) end   as PD,
  case when A.pack_grade like 'FR' then ( A.roll_length ) end as FRC
  
//   cast( case when BB.zunit = 'M'  then 'KG' else BB.zunit end as abap.unit( 3 ) ) as MaterialBaseUnit,
//     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//     BB.QTY  as QTY
//  
 
}  
  //



group by
  A.material_number,
  A.pack_grade,
  A.posting_date,
  A.plant,
  A.pack_grade,
  A.roll_length,
  B.material101,
  B.MaterialBaseUnit,
//  BB.zunit,
 B.QTY

