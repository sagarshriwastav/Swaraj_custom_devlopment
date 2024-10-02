@AbapCatalog.sqlViewName: 'YWEFTYARN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Weft Yarn Consumption Report'
define view ZMM_WEFT_YARN_CONSUMPTIO_OPEN2 
  with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date 
    as select from ZMM_WEFT_YARN_CONSUMPTION_OPEN( P_KeyDate: $parameters.P_KeyDate )
{
    key Material,
    key Plant,    
    key Customer, 
    MaterialBaseUnit,
    sum( MatlWrhsStkQtyInMatlBaseUnit ) as OpeningBalance
}  
where MatlWrhsStkQtyInMatlBaseUnit > 0
   group by 
    Material,
    Plant,
    Customer,
    MaterialBaseUnit
