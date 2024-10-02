@AbapCatalog.sqlViewName: 'YSTOCKMIS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_STOCK_MIS_REPORT'
define view ZMM_STOCK_MIS_REPORT_CDS 
 with parameters 
 @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date
 as select from I_MaterialStock_2 as a 
   left outer join I_Product as b on ( b.Product = a.Material )
   
   { 
      key b.ProductType ,
      key a.Plant,
      cast( case when a.MaterialBaseUnit = 'KG' or MaterialBaseUnit = 'PAK' or MaterialBaseUnit = 'ST' then 'M'  else  MaterialBaseUnit end as  abap.unit( 3 ) ) as  MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(a.MatlWrhsStkQtyInMatlBaseUnit) as Openingqty
      
      
      
   } where MatlDocLatestPostgDate <= dats_add_days ($parameters.P_KeyDate,-1,'UNCHANGED')
   
   group by b.ProductType,
   a.MaterialBaseUnit,
   a.Plant
