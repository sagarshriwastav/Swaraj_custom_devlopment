@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'party wise short report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
    }
define view entity ZPARTY_WISE_SHORT_REP as select from ZPACK_HEAD_REP_CDS as a
left outer join ZPP_LOOMWISE_DAMAGE_FRC_MTR as b on ( a.MaterialNumber = b.Material and a.Plant = b.Plant 
                                                                        and a.PostingDate = b.PostingDate )                                               

{
       key a.Party,
           a.PostingDate,
           a.MaterialNumber,
  case when a.PackGrade like 'F1' then ( a.RollLength ) end  as fresh,
  case when a.PackGrade like 'SW' then ( a.RollLength ) end  as  SW,
  case when a.PackGrade like 'OT' then ( a.RollLength ) end  as other,
  case when a.PackGrade like 'PD' then ( a.RollLength ) end  as PD,
  case when a.PackGrade like 'QD' then ( a.RollLength ) end  as QD,
  case when a.PackGrade like 'CD' then ( a.RollLength ) end  as CD,
  case when a.PackGrade like 'SV' then ( a.RollLength ) end  as SV,
  case when a.PackGrade like 'SL' then ( a.RollLength ) end  as SL,
   // b.MaterialBaseUnit,
  //  cast( cast( b.MaterialBaseUnit as abap.quan( 13, 0 ) ) as abap.dec(13,0) ) as MaterialBaseUnit,
     cast( case when b.MaterialBaseUnit = 'M'  then 'KG' else b.MaterialBaseUnit end as abap.unit( 3 ) ) as MaterialBaseUnit,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     b.FrcMtr  as FRC
}  
group by   a.Party,
           a.PostingDate,
           a.MaterialNumber,
           b.MaterialBaseUnit,
           a.PackGrade,
           a.RollLength,
           b.FrcMtr
           
           
           
           
