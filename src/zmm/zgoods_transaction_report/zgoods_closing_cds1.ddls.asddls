@AbapCatalog.sqlViewName: 'YCLOSE1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Goods Transaction Report'
define view ZGOODS_CLOSING_CDS1 with parameters
    p_fromdate : abap.dats
    as select from ZGOODS_CLOSING_CDS( P_KeyDate:$parameters.p_fromdate)
{
    key Material,
    key Plant,
    MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum( MatlWrhsStkQtyInMatlBaseUnit ) as Opening
}  
  group by  
    Material,
    Plant,
    MaterialBaseUnit
