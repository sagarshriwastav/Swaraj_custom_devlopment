@AbapCatalog.sqlViewName: 'YMISSU'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_STOCK_MIS_REP_FIN_CDS'
define view ZMM_STOCK_MIS_REP_FIN_CDS with parameters
    p_fromdate : abap.dats
 as select from ZMM_STOCK_MIS_CLOSING_CDS( P_KeyDate:$parameters.p_fromdate)
 
 {  
     key ProductType,
     key Plant,
         MaterialBaseUnit,
   //      cast( case when MaterialBaseUnit = 'KG'  then 'M'  else  MaterialBaseUnit end as  abap.unit( 3 ) ) as  MaterialBaseUnit ,
         @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
         sum( Closingqty) as Closingqty
     
 } group by ProductType,
 Plant,
 MaterialBaseUnit
