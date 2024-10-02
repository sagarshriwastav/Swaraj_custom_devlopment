@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MATERIAL_PACKHADER'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_MATERIAL_PACKHADER as select from zpackhdr as A
{  key A.material_number,
  key     A.batch,
  //     A.pack_grade,
//       A.roll_length,
       A.posting_date,
       

   sum(case when A.pack_grade like 'F1' then (A.roll_length)  end  )  as fresh,
   sum(case when A.pack_grade  like 'QD' then (A.roll_length) end  )  as QD,
  sum( case when A.pack_grade like 'CD' then ( A.roll_length ) end ) as CD,
  sum(case when A.pack_grade like 'SV' then ( A.roll_length ) end ) as SV,
  sum(case when A.pack_grade like 'SL' then ( A.roll_length ) end)  as SL,
  sum(case when A.pack_grade like 'SW' then (A.roll_length) end )  as SW,
  sum(case when A.pack_grade like 'OT' then (A.roll_length) end  ) as OTH,
  sum(case when A.pack_grade like 'RF' then (A.roll_length) end )  as RF,
  sum(case when A.pack_grade like 'PD' then (A.roll_length) end )  as PD,
  sum(case when A.pack_grade like 'FR' then ( A.roll_length )  end ) as FR
    
    
} 
group by 

    A.material_number,
    A.batch,
   //  A.pack_grade
  //     A.roll_length,
       A.posting_date
