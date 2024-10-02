@AbapCatalog.sqlViewName: 'YCOLSING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_STOCK_MIS_CLOSING_CDS'
define view ZMM_STOCK_MIS_CLOSING_CDS with parameters 
 @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
 as select from I_MaterialStock_2 as a 
   left outer join I_Product as b on ( b.Product = a.Material )
 //  left outer join I_ProductValuationBasic as c on ( a.Material = c.Product  )
   
   { 
      key b.ProductType ,
      key a.Plant,
   //   a.MaterialBaseUnit,
      cast( case when a.MaterialBaseUnit = 'KG' or a.MaterialBaseUnit = 'PAK' or a.MaterialBaseUnit = 'ST' then 'M'  else  MaterialBaseUnit end as  abap.unit( 3 ) ) as  MaterialBaseUnit ,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(a.MatlWrhsStkQtyInMatlBaseUnit) as Closingqty
  //    c.Currency,
  //    @Semantics.amount.currencyCode: 'Currency'
  //    c.StandardPrice as StandardPrice,
  //    @Semantics.amount.currencyCode: 'Currency'
  //    sum(c.MovingAveragePrice) as MovingAveragePrice
      
      
      
   } where  a.MatlDocLatestPostgDate <= $parameters.P_KeyDate
   
   group by b.ProductType,
   a.MaterialBaseUnit,
   a.Plant
 //  c.Currency,
 //  c.MovingAveragePrice,
 //  c.StandardPrice
