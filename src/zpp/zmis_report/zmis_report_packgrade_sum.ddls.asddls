@AbapCatalog.sqlViewName: 'YMISPACKGRADE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_REPORT_PACKGRADE_SUM'
define view ZMIS_REPORT_PACKGRADE_SUM as select from ZPACK_HEAD_REP_CDS 
{
    key Setcode as Setno,
     sum(case when PackGrade like 'CD' then ( RollLength ) end ) as CD,
     sum(case when PackGrade like 'SV' then ( RollLength ) end ) as SV1,
     sum(case when PackGrade like 'SL' then ( RollLength ) end ) as SL,
     sum(case when PackGrade like 'F1' then ( RollLength ) end ) as F1,
     sum(case when PackGrade like 'SW' then ( RollLength ) end ) as  SW,
     sum(case when PackGrade like 'OT' then ( RollLength ) end ) as OTH,
     sum(case when PackGrade like 'PD' then ( RollLength ) end ) as PDS,
     sum(case when PackGrade like 'QD' then ( RollLength ) end ) as QDS,
     sum(case when PackGrade like 'FR' then ( RollLength ) end ) as FR
   
} group by Setcode
