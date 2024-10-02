@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'loomwise damage report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZLOOMWISE_DAMAGE_REPORT_CDS 
 as select from ZPACK_HEAD_REP_CDS as a
                     left outer join zdnmfault as b on ( a.MaterialNumber = b.material_number
                                                        and a.Plant = b.plant and a.MatDoc = b.mat_doc
                                                        and a.MatDocyear = b.mat_docyear ) 
                   left outer join ZPP_LOOMWISE_DAMAGE_FRC_MTR as c on ( a.MaterialNumber = c.Material and a.Plant = c.Plant 
                                                                        and a.PostingDate = c.PostingDate )                                   
{
     key a.Setno as dyesetno,
        a.Loomno,
        a.Party,
        a.MaterialNumber as SortNo,
        a.PostingDate,
     case when a.PackGrade like 'CD' then ( a.RollLength ) end  as CD,
     case when a.PackGrade like 'SV' then ( a.RollLength ) end  as SV,
     case when a.PackGrade like 'SL' then ( a.RollLength ) end  as SL,
     case when a.PackGrade like 'F1' then ( a.RollLength ) end  as fresh,
     case when a.PackGrade like 'SW' then ( a.RollLength ) end  as  SW,
     case when a.PackGrade like 'OT' then ( a.RollLength ) end  as other,
     case when a.PackGrade like 'PD' then ( a.RollLength ) end  as PD,
     case when a.PackGrade like 'QD' then ( a.RollLength ) end  as QD,
        c.MaterialBaseUnit,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     c.FrcMtr  as FRC,
     
  (  cast( case when b.tometer is not null and b.ftype = '101' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '101'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as  WARPSLUBBY, 
     
     (  cast(case when b.tometer is not initial and b.ftype = '102'  then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not initial and b.ftype = '102' then b.meter   else 0 end as abap.dec( 13, 3 ) ) )  as WEFTSLUBBY,
     
     (  cast(case when b.tometer is not null and b.ftype = '103' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '103'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as CONTAMINATION,
     
     (  cast(case when b.tometer is not null and b.ftype = '104' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '104'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as UNEVENWEFT,
     
      ( cast(case when b.tometer is not null and b.ftype = '105' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '105'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG105,
     
      ( cast(case when b.tometer is not null and b.ftype = '106' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '106'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG106,
     
     ( cast(case when b.tometer is not null and b.ftype = '107' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '107'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG107,
     
         (  cast(case when b.tometer is not null and b.ftype = '108' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '108'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG108,
     
         (  cast(case when b.tometer is not null and b.ftype = '109' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '109'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG109,
     
         (  cast(case when b.tometer is not null and b.ftype = '110' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '110'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG110,
     
         (  cast(case when b.tometer is not null and b.ftype = '111' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '111'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG111,
     
         (  cast(case when b.tometer is not null and b.ftype = '112' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '112'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG112,
     
         (  cast(case when b.tometer is not null and b.ftype = '113' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '113'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG113,
     
         (  cast(case when b.tometer is not null and b.ftype = '114' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '114'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG114,
     
         (  cast(case when b.tometer is not null and b.ftype = '115' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '115'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG115,
     
         (  cast(case when b.tometer is not null and b.ftype = '116' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '116'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG116,
     
         (  cast(case when b.tometer is not null and b.ftype = '117' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '117'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG117,
     
         (  cast(case when b.tometer is not null and b.ftype = '118' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '118'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG118,
     
         (  cast(case when b.tometer is not null and b.ftype = '119' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '119'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG119,
     
         (  cast(case when b.tometer is not null and b.ftype = '120' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '120'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG120,
     
         (  cast(case when b.tometer is not null and b.ftype = '121' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '121'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG121,
     
         (  cast(case when b.tometer is not null and b.ftype = '122' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '122'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG122,
     
         (  cast(case when b.tometer is not null and b.ftype = '123' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '123'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG123,
     
         (  cast(case when b.tometer is not null and b.ftype = '124' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '124'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG124,
     
         (  cast(case when b.tometer is not null and b.ftype = '125' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '125'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG125,
     
       (  cast(case when b.tometer is not null and b.ftype = '201' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '201'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG201,
     
            (  cast(case when b.tometer is not null and b.ftype = '202' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '202'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG202,
     
            (  cast(case when b.tometer is not null and b.ftype = '203' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '203'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG203,
     
            (  cast(case when b.tometer is not null and b.ftype = '204' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '204'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG204,
     
            (  cast(case when b.tometer is not null and b.ftype = '205' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '205'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG205,
     
            (  cast(case when b.tometer is not null and b.ftype = '206' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '206'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG206,
     
            (  cast(case when b.tometer is not null and b.ftype = '207' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '207'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG207,
     
            (  cast(case when b.tometer is not null and b.ftype = '208' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '208'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG208,
     
            (  cast(case when b.tometer is not null and b.ftype = '209' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '209'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG209,
     
            (  cast(case when b.tometer is not null and b.ftype = '210' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '210'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG210,
     
            (  cast(case when b.tometer is not null and b.ftype = '211' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '211'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG211,
     
            (  cast(case when b.tometer is not null and b.ftype = '212' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '212'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG212,
     
            (  cast(case when b.tometer is not null and b.ftype = '213' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '213'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG213,
     
            (  cast(case when b.tometer is not null and b.ftype = '214' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '214'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG214,
     
     
            (  cast(case when b.tometer is not null and b.ftype = '215' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '215'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG215,
     
            (  cast(case when b.tometer is not null and b.ftype = '216' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '216'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG216,
     
            (  cast(case when b.tometer is not null and b.ftype = '217' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '217'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG217,
     
            (  cast(case when b.tometer is not null and b.ftype = '218' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '218'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG218,
     
      (  cast(case when b.tometer is not null and b.ftype = '301' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '301'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG301,
     
      (  cast(case when b.tometer is not null and b.ftype = '302' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '302'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG302,
     
      (  cast(case when b.tometer is not null and b.ftype = '303' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '303'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG303,
     
      (  cast(case when b.tometer is not null and b.ftype = '304' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '304'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG304,
     
      (  cast(case when b.tometer is not null and b.ftype = '305' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '305'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG305,
     
      (  cast(case when b.tometer is not null and b.ftype = '306' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '306'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG306,
     
      (  cast(case when b.tometer is not null and b.ftype = '307' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '307'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG307,
     
      (  cast(case when b.tometer is not null and b.ftype = '308' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '308'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG308,
     
      (  cast(case when b.tometer is not null and b.ftype = '309' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '309'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG309,
     
      (  cast(case when b.tometer is not null and b.ftype = '310' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '310'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG310,
     
      (  cast(case when b.tometer is not null and b.ftype = '311' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '311'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG311,
     
      (  cast(case when b.tometer is not null and b.ftype = '312' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '312'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG312,
     
      (  cast(case when b.tometer is not null and b.ftype = '313' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '313'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG313,
     
      (  cast(case when b.tometer is not null and b.ftype = '314' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '314'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG314,
     
      (  cast(case when b.tometer is not null and b.ftype = '315' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '315'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG315,
     
      (  cast(case when b.tometer is not null and b.ftype = '316' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '316'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG316,
     
      (  cast(case when b.tometer is not null and b.ftype = '317' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '317'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG317,
     
      (  cast(case when b.tometer is not null and b.ftype = '318' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '318'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG318,
     
      (  cast(case when b.tometer is not null and b.ftype = '319' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '319'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG319,
     
      (  cast(case when b.tometer is not null and b.ftype = '320' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '320'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG320,
     
      (  cast(case when b.tometer is not null and b.ftype = '321' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '321'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG321,
     
      (  cast(case when b.tometer is not null and b.ftype = '322' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '322'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG322,
     
      (  cast(case when b.tometer is not null and b.ftype = '323' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '323'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG323,
     
      (  cast(case when b.tometer is not null and b.ftype = '324' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '324'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG324,
     
      (  cast(case when b.tometer is not null and b.ftype = '325' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '325'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG325,
     
      (  cast(case when b.tometer is not null and b.ftype = '326' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '326'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG326,
     
      (  cast(case when b.tometer is not null and b.ftype = '327' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '327'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG327,
     
      (  cast(case when b.tometer is not null and b.ftype = '328' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '328'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG328,
     
      (  cast(case when b.tometer is not null and b.ftype = '329' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '329'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG329,
     
      (  cast(case when b.tometer is not null and b.ftype = '330' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '330'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG330,
     
      (  cast(case when b.tometer is not null and b.ftype = '331' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '331'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG331,
     
      (  cast(case when b.tometer is not null and b.ftype = '332' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '332'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG332,
     
      (  cast(case when b.tometer is not null and b.ftype = '333' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '333'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG333,
     
      (  cast(case when b.tometer is not null and b.ftype = '334' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '334'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG334,
     
      (  cast(case when b.tometer is not null and b.ftype = '335' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '335'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG335,
     
      (  cast(case when b.tometer is not null and b.ftype = '336' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '336'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG336,
     
      (  cast(case when b.tometer is not null and b.ftype = '337' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '337'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG337,
     
      (  cast(case when b.tometer is not null and b.ftype = '338' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '338'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG338,
     
     (  cast(case when b.tometer is not null and b.ftype = '339' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '339'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG339,
     
     (  cast(case when b.tometer is not null and b.ftype = '340' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '340'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG340,
     
     (  cast(case when b.tometer is not null and b.ftype = '341' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '341'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG341,
     
     (  cast(case when b.tometer is not null and b.ftype = '401' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '401'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG401,
     
          (  cast(case when b.tometer is not null and b.ftype = '402' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '402'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG402,
     
          (  cast(case when b.tometer is not null and b.ftype = '403' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '403'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG403,
     
          (  cast(case when b.tometer is not null and b.ftype = '404' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '404'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG404,
     
          (  cast(case when b.tometer is not null and b.ftype = '405' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '405'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG405,
     
          (  cast(case when b.tometer is not null and b.ftype = '406' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '406'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG406,
     
          (  cast(case when b.tometer is not null and b.ftype = '407' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '407'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG407,
     
          (  cast(case when b.tometer is not null and b.ftype = '408' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '408'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG408,
     
          (  cast(case when b.tometer is not null and b.ftype = '409' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '409'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG409,
    
          (  cast(case when b.tometer is not null and b.ftype = '410' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '410'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG410,
     
          (  cast(case when b.tometer is not null and b.ftype = '411' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '411'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG411,
     
          (  cast(case when b.tometer is not null and b.ftype = '412' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '412'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG412,
     
          (  cast(case when b.tometer is not null and b.ftype = '413' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '413'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG413,
     
          (  cast(case when b.tometer is not null and b.ftype = '414' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '414'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG414,
     
          (  cast(case when b.tometer is not null and b.ftype = '415' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '415'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG415,
     
          (  cast(case when b.tometer is not null and b.ftype = '416' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '416'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG416,
     
          (  cast(case when b.tometer is not null and b.ftype = '417' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '417'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG417,
     
          (  cast(case when b.tometer is not null and b.ftype = '418' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '418'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG418,
     
          (  cast(case when b.tometer is not null and b.ftype = '419' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '419'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG419,
     
          (  cast(case when b.tometer is not null and b.ftype = '420' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '420'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG420,
     
          (  cast(case when b.tometer is not null and b.ftype = '421' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '421'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG421,
     
          (  cast(case when b.tometer is not null and b.ftype = '422' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '422'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG422,
     
          (  cast(case when b.tometer is not null and b.ftype = '423' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '423'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG423,
     
          (  cast(case when b.tometer is not null and b.ftype = '424' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '424'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG424,
     
          (  cast(case when b.tometer is not null and b.ftype = '425' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '425'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG425,
     
          (  cast(case when b.tometer is not null and b.ftype = '426' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '426'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG426,
     
          (  cast(case when b.tometer is not null and b.ftype = '427' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '427'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG427,
     
          (  cast(case when b.tometer is not null and b.ftype = '428' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '428'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG428,
     
          (  cast(case when b.tometer is not null and b.ftype = '429' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '429'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG429,
     
          (  cast(case when b.tometer is not null and b.ftype = '430' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '430'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG430,
     
          (  cast(case when b.tometer is not null and b.ftype = '431' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '431'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG431,
     
          (  cast(case when b.tometer is not null and b.ftype = '432' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '432'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG432,
     
          (  cast(case when b.tometer is not null and b.ftype = '501' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '501'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG501,
     
          (  cast(case when b.tometer is not null and b.ftype = '502' then b.tometer else 0 end as abap.dec( 13, 3 ) ) -
     cast( case when b.meter  is not null and b.ftype = '502'then b.meter   else 0 end as abap.dec( 13, 3 ) ) )   as FAULTDMG502
       
    
    
    
 }//group by a.Setno,
//                a.Loomno,
//                a.MaterialNumber,
//                a.PostingDate,
//                b.tometer,
//                b.ftype,
//                b.meter,
//                a.PackGrade,
//                a.RollLength
//               
