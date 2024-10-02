@AbapCatalog.sqlViewName: 'ZDAMAGE_REPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZDAMAGE_REPORT'
define view ZDAMAGE_REPORT_CDS with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from ZPACK_HEAD_REP_CDS  as a 
                left outer join ZPACK_HEAD_REP_CDS as b on ( b.MaterialNumber = a.MaterialNumber  // and b.PostingDate = a.PostingDate 
                                                     and b.MatDoc = a.MatDoc and b.MatDocyear = a.MatDocyear  )
                                                     
                left outer join ZPACK_HEAD_REP_CDS as c on ( c.MaterialNumber = a.MaterialNumber  // and c.PostingDate = a.PostingDate 
                                                     and c.MatDoc = a.MatDoc and c.MatDocyear = a.MatDocyear and c.PackGrade = 'F1' )
                                                     
                left outer join ZPACK_HEAD_REP_CDS as GS on ( GS.MaterialNumber = a.MaterialNumber  // and c.PostingDate = a.PostingDate 
                                                     and GS.MatDoc = a.MatDoc and GS.MatDocyear = a.MatDocyear and GS.PackGrade = 'SW' )                                     
                                                     
                left outer join ZPACK_HEAD_REP_CDS as d   on ( d.MaterialNumber = a.MaterialNumber  // and d.PostingDate = a.PostingDate 
                                                     and d.MatDoc = a.MatDoc and d.MatDocyear = a.MatDocyear and d.PackGrade = 'CD' )
                                                     
                left outer join ZPACK_HEAD_REP_CDS as e  on ( e.MaterialNumber = a.MaterialNumber  // and e.PostingDate = a.PostingDate 
                                                     and e.MatDoc = a.MatDoc and e.MatDocyear = a.MatDocyear and e.PackGrade = 'SL' )
                                                     
                left outer join ZPACK_HEAD_REP_CDS as f on ( f.MaterialNumber = a.MaterialNumber  // and f.PostingDate = a.PostingDate 
                                                     and f.MatDoc = a.MatDoc and f.MatDocyear = a.MatDocyear and f.PackGrade = 'SV' )
                                                     
               left outer join zdnmfault_spingdmgmtr( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) 
                                                      as g on (    g.material_number = a.MaterialNumber and g.plant = a.Plant  )
                                                      
               left outer join ZDMAGE_REPORT_DYDMGMTR( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) 
                                                  as h on (   h.material_number = a.MaterialNumber and h.plant = a.Plant  )
                                                  
               left outer join ZDMAGE_REPORT_WEAVDMGMTR( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) 
                                                    as i on ( i.material_number = a.MaterialNumber and i.plant = a.Plant  )
                                                    
              left outer join ZDMAGE_REPORT_FINISHDMGMTR( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) 
                                                    as j on ( j.material_number = a.MaterialNumber and j.plant = a.Plant  ) 
                                                    
              left outer join ZDMAGE_REPORT_OTHERDMGMTR( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) 
                                                   as k on ( k.material_number = a.MaterialNumber and k.plant = a.Plant  )  
             left outer join I_ProductDescription_2 as GSS on ( GSS.Product = a.MaterialNumber and GSS.Language = 'E' ) 
             left outer join ZPP_LOOMWISE_DAMAGE_FRC_MTR as l on ( a.MaterialNumber = l.Material and a.Plant = l.Plant 
                                                                        and a.PostingDate = l.PostingDate )                                      
                                                              
                

{

key a.MaterialNumber, 
key a.Plant,
     a.UnitField, 
     cast( 'M' as abap.unit( 3 ) )  as UnitFieldMTR,
     @Semantics.quantity.unitOfMeasure: 'UnitField'
    sum(b.RollLength) as Total_Meter,
     @Semantics.quantity.unitOfMeasure: 'UnitField'
    sum(c.RollLength) as Fresh_Meter,    
    cast( '%' as abap.unit(3) ) as Zunitpecent,
    @Semantics.quantity.unitOfMeasure: 'Zunitpecent'
    cast( sum( c.RollLength ) as abap.fltp )  * ( cast( 133.333 as abap.fltp) ) as Fresh_Percent,
     @Semantics.quantity.unitOfMeasure: 'UnitField'
    sum(d.RollLength) as CD_METER,
     @Semantics.quantity.unitOfMeasure: 'UnitField'
    sum(e.RollLength) as SL_METER,
     @Semantics.quantity.unitOfMeasure: 'UnitField'
    sum(f.RollLength) as SV_METER,
     @Semantics.quantity.unitOfMeasure: 'UnitField'
    sum(GS.RollLength)  as SW_METER,
     @Semantics.quantity.unitOfMeasure: 'UnitField'
  cast((  cast(case when g.tometer is not null then g.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when g.meter  is not null then g.meter   else 0 end as abap.dec( 13, 3 ) ) ) as abap.dec( 13, 3 )) as  SPINGDMGMTR ,
      @Semantics.quantity.unitOfMeasure: 'UnitField'
  cast((  cast(case when h.tometer is not null then h.tometer else 0 end as abap.dec( 13, 3 ) )  - 
     cast( case when h.meter is not null then  h.meter else 0 end as abap.dec( 13, 3 ) ) ) as abap.dec( 13, 3 ))  as  DYDMGMTR ,
      @Semantics.quantity.unitOfMeasure: 'UnitField'
    cast((  cast(case when i.tometer is not null then i.tometer else 0 end as abap.dec( 13, 3 ) )  - 
     cast( case when i.meter is not null then  i.meter else 0 end as abap.dec( 13, 3 ) ) ) as abap.dec( 13, 3 ) )  as  WEAVDMGMTR ,
      @Semantics.quantity.unitOfMeasure: 'UnitField'
     cast( (  cast(case when j.tometer is not null then j.tometer else 0 end as abap.dec( 13, 3 ) )  - 
     cast( case when j.meter is not null then  j.meter else 0 end as abap.dec( 13, 3 ) ) ) as abap.dec( 13, 3 ) ) as  FINISHDMGMTR ,
      @Semantics.quantity.unitOfMeasure: 'UnitField'
     cast( (  cast(case when k.tometer is not null then k.tometer else 0 end as abap.dec( 13, 3 ) )  - 
     cast( case when k.meter is not null then  k.meter else 0 end as abap.dec( 13, 3 ) ) ) as abap.dec( 13, 3 ) ) as  OTHERDMGMTR ,
     GSS.ProductDescription,
   //  l.MaterialBaseUnit,
    // @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     cast(l.FrcMtr as abap.dec(13,0) )  as FRC,
     case when a.PackGrade like 'SW' then ( a.RollLength ) end  as  SW,
  case when a.PackGrade like 'OT' then ( a.RollLength ) end  as other  
    


} where a.PostingDate >= $parameters.p_fromdate
  and   a.PostingDate <= $parameters.p_todate

group by 
         a.MaterialNumber,
         a.UnitField,
         a.Plant,
         g.meter ,
         g.tometer,
         h.meter,
         h.tometer,
         i.meter,
         i.tometer,
         j.meter,
         j.tometer,
         k.meter,
         k.tometer,
         GSS.ProductDescription,
   //      l.MaterialBaseUnit,
         l.FrcMtr,
         a.PackGrade,
         a.RollLength
         
   
