@AbapCatalog.sqlViewName: 'YLOOMWISED'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_LOOMWISE_DAMAGE_REP'
define view ZPP_LOOMWISE_DAMAGE_REP as select from ZPACK_HEAD_REP_CDS as a
             
{
     key Setno as dyesetno,
        Loomno,
        Party,
        MaterialNumber as SortNo,
        PostingDate,
   
     sum(case when PackGrade like 'CD' then ( RollLength ) end )  as CD,
     sum(case when PackGrade like 'SV' then ( RollLength ) end ) as SV,
     sum(case when PackGrade like 'SL' then ( RollLength ) end ) as SL,
     sum(case when PackGrade like 'F1' then ( RollLength ) end ) as fresh,
     sum(case when PackGrade like 'SW' then ( RollLength ) end ) as  SW,
     sum(case when PackGrade like 'OT' then ( RollLength ) end ) as other,
     sum(case when PackGrade like 'PD' then ( RollLength ) end ) as PD,
     sum(case when PackGrade like 'QD' then ( RollLength ) end ) as QD
   
     
     
     
     
     
  } group by Setno,
             Loomno,
             Party,
             MaterialNumber,
            PostingDate
   
