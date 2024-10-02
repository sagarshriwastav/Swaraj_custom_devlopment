@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yrarn Packing Screen'
define root view entity YPP_COMPONENT_STOCK as select from I_MaterialStock

{
    key Plant ,
    key Material,
        StorageLocation,
        Batch,
        MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum(MatlWrhsStkQtyInMatlBaseUnit)  as STOCKQTY
}


group by  
        Plant ,
        Material,
        StorageLocation,
        Batch,
        MaterialBaseUnit
