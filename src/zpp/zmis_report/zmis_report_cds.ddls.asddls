@AbapCatalog.sqlViewName: 'YMISREPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_REPORT_CDS'
define view ZMIS_REPORT_CDS as select from  ZPP_BOTTOM_PERCENTAGE_261 as b  
        left outer join ZPP_BOTTOM__531_532 as c on (  c.orderid = b.OrderID and c.Batch = b.Batch )
    //    left outer join I_MaterialDocumentItem_2 as d on ( d.MaterialDocument = a.GoodsMovement )
{
      b.Batch,
      cast( 'KG' as abap.unit( 3 ) ) as zunit,
       @Semantics.quantity.unitOfMeasure: 'zunit'
        sum(b.Issue_Cotton_Yarn) as CottonIssueWeight,
   //     cast( case when c.BaseUnit = 'M'  then 'KG' else c.BaseUnit end as abap.unit( 3 ) ) as BaseUnit,
         cast( 'M' as abap.unit( 3 ) ) as  BaseUnit,
        sum(c.Bottom) as Bottom
      
      
} 
   group by b.Batch
