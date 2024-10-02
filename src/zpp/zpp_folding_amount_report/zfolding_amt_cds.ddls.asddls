@AbapCatalog.sqlViewName: 'YFOLDINGAMOUNT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZFOLDING_AMT_CDS'
define view ZFOLDING_AMT_CDS
  as select from    ZPP_GREY_GRN_REPORT as a
    left outer join ZFOLDING_AMOUNT_CD  as b on(
      b.SalesOrder         = a.Salesord
      and b.SalesOrderItem = a.Salesorderitem
      and b.ConditionType  = 'ZPIK'
    )
    left outer join ZFOLDING_AMOUNT_CD  as c on(
      c.SalesOrder         = a.Salesord
      and c.SalesOrderItem = a.Salesorderitem
      and c.ConditionType  = 'ZROL'
    )
    left outer join ZFOLDING_AMOUNT_CD  as d on(
      d.SalesOrder         = a.Salesord
      and d.SalesOrderItem = a.Salesorderitem
      and d.ConditionType  = 'ZMND'
    )


{

  key a.Plant,
  key a.Batch,
  key a.Recbatch,
  key a.Materialdocument101,
      a.Materialdocumentyear101,
      a.Postingdate,
      a.Optcode,
      a.Shift,
      a.Srno,
      a.zCount,
      a.Loomno,
      a.Material,
      a.Materialdec,
      a.Rollno,
      a.Partybeam,
      //   cast( 'M' as abap.cuky( 5 ) ) as ConditionCurrency,
      //   @Semantics.amount.currencyCode: 'ConditionCurrency'
      cast( a.Pick as abap.dec( 13, 3  ) )                         as Pick,
      //   a.Pick,
      a.Partyname,
      a.Quantity,
      a.Netwt,
      a.Wtmtr,
      a.Stdwt,
      a.Prodorder,
      a.Sloc,
      a.Shadeno,
      a.Remark,
      a.Uom,
      a.Ukg,
      a.Salesord,
      a.Salesorderitem,
      a.Materialdocument261,
      a.Materialdocumentyear261,
      a.Stock,
      a.Delivery,
      a.grosswt,
      a.setno,
      a.selvedge,
      a.GoodsMovementIsCancelled,
      // cast( case when  b.ConditionCurrency = 'INR' then 'M' end as abap.char( 10 ) ) as ConditionCurrency,
      b.ConditionCurrency,
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      b.ConditionAmount,
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      c.ConditionAmount1,
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      d.ConditionAmount2,
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      cast( a.Pick * b.ConditionAmount as abap.dec( 13, 2 ) )      as Pick_Rate,
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      cast( a.Quantity * c.ConditionAmount1 as abap.dec( 13, 2 ) ) as MENDING_AMT,
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      cast( a.Quantity * d.ConditionAmount2 as abap.dec( 13, 2 ) ) as Rolling_Rate


} //where b.ConditionType = 'ZPIK' and b.ConditionType = 'ZROL' and b.ConditionType = 'ZMND'
