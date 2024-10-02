@AbapCatalog.sqlViewName: 'YOPENINGSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_OPENING_SUM'
define view ZMM_OPENING_SUM with parameters
    p_fromdate : abap.dats
    as select from ZMM_STOCK_MIS_REPORT_CDS( P_KeyDate:$parameters.p_fromdate)
{
    key ProductType,
    key Plant,
    MaterialBaseUnit,
 //      cast( case when MaterialBaseUnit = 'KG' or MaterialBaseUnit = 'PAK' or MaterialBaseUnit = 'ST' then 'M'  else  MaterialBaseUnit end as  abap.unit( 3 ) ) as  MaterialBaseUnit, 
    //    cast( 'M' as abap.unit( 3 ) ) as   MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum(Openingqty) as Openingqty
    
}  
   group by   
    ProductType,
    Plant,
    MaterialBaseUnit
