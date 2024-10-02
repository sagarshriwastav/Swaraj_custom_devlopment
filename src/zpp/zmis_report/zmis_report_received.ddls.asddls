@AbapCatalog.sqlViewName: 'YMIS_RECEIVED'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_REPORT_RECEIVED'
define view ZMIS_REPORT_RECEIVED as select from ZMM_GREY_RECEIPT_REGISTER_CDS
{
    Set_code,
    MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(QuantityInBaseUnit) as QuantityInBaseUnit
    
} group by Set_code,
           MaterialBaseUnit
