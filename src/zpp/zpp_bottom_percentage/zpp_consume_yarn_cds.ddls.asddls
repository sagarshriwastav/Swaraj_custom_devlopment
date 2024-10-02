@AbapCatalog.sqlViewName: 'YCONSUME'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_CONSUME_YARN_CDS'
define view ZPP_CONSUME_YARN_CDS as select from I_MfgOrderDocdGoodsMovement as a 
         left outer join ZPP_WARPING_AVGBPM as b on (  b.ZfsetNo = a.Batch )
         left outer join ZPP_MCARDR_CDS1 as c on ( c.dyesort = b.Material  )
         
{
       key a.Batch,
        a.BaseUnit,
        c.zptotends,
       a.QuantityInBaseUnit  ,
      @Semantics.quantity.unitOfMeasure: 'BaseUnit'     
       ( c.zptotends - 24 )  * ( a.QuantityInBaseUnit )  as ConsumeYarn,
        ( 1693 * b.Zcount ) as ConsumeYarn1,
        @Semantics.quantity.unitOfMeasure: 'BaseUnit'     
        ( (c.zptotends) - 32 ) * (a.QuantityInBaseUnit)  as ConsumeYarn2 ,
//        
       (  cast( ( c.zptotends - 24 )  * ( a.QuantityInBaseUnit  )  as abap.fltp ) /  cast( ( 1693  * b.Zcount  ) as abap.fltp )  )  as NEWConsumeYarn,
       ( cast( ( c.zptotends - 32 )  * ( a.QuantityInBaseUnit )  as abap.fltp ) /  cast( (  1693  * b.Zcount  ) as abap.fltp )   )  as NEWConsumeYarn1,
         
          c.zptotends - 24 as zptotends24,
          c.zptotends - 32 as zptotends32
          
         
//      CASE  WHEN ( c.zptotends <= 8990
//    OR (c.zptotends -  24 <= 8990)
//    
//    OR (c.zptotends - 32 > 8990) ) 
//        
//  ( (cast((c.zptotends - 24) * (a.QuantityInBaseUnit) as abap.fltp) / cast((1693 * b.Zcount) as abap.fltp)) * cast(1000 as abap.fltp)
//) as NEWConsumeYarn
         
         
} where b.Zcount > 0
group by a.Batch,
        a.BaseUnit,
         c.zptotends,
         b.Zcount,
         a.QuantityInBaseUnit
