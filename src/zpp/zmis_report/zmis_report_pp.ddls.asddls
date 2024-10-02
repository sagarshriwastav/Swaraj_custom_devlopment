@AbapCatalog.sqlViewName: 'YPP_MIS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_REPORT_PP'
define view ZMIS_REPORT_PP as select from ZPP_BOTTOM_PERCENTAGE_CDS as a
{
   key a.Warping_Short,
       a.PostingDate,
       a.Batch,
       a.Dying_Short,
       a.Cotton_Yarn_Mill_Name as millname,
       a.Cotton_Yarn_Lotno as lotnumber,
       cast( case when a.zunit = 'KG' then ''  end as  abap.unit( 3 ) ) as  zunit2 ,
       @Semantics.quantity.unitOfMeasure : ''
       a.Zcount as ZCount,
       a.MaterialBaseUnit,
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
       (a.Warping_Length) as WarpingLength,
       a.zunit,
       @Semantics.quantity.unitOfMeasure: 'zunit'
       sum(a.Issue_Cotton_Yarn) as CottonIssueWeight,
       cast( case when a.BaseUnit = 'M'  then 'KG' else a.BaseUnit end as abap.unit( 3 ) ) as BaseUnit,
       sum(a.Bottom) as Bottom
  //     cast( case when a.zunit = 'KG' then ''  end as  abap.unit( 3 ) ) as  zunit2 ,
  //     @Semantics.quantity.unitOfMeasure : ''
  //     a.Zcount as ZCount
       
       
} group by  a.Warping_Short,
            a.PostingDate,
            a.Batch,
            a.Dying_Short,
            a.MaterialBaseUnit,
            a.zunit,
            a.BaseUnit,
            a.Cotton_Yarn_Mill_Name,
            a.Cotton_Yarn_Lotno,
            a.zunit,
            a.Zcount,
            a.Warping_Length
