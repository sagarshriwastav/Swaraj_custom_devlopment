@AbapCatalog.sqlViewName: 'YNCLOSE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Facory Beam Qty'
define view Yarn_Factory_Beam_CLOSE_N with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date 
    as select from Yarn_Factory_Beam_CLOSE( P_KeyDate: $parameters.P_KeyDate )
{
    Material,
    Plant,
    MaterialBaseUnit,
    Customer,
    sum( MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit
}  where MatlWrhsStkQtyInMatlBaseUnit > 0
   group by 
    Material,
    Plant,
    MaterialBaseUnit,
    Customer
