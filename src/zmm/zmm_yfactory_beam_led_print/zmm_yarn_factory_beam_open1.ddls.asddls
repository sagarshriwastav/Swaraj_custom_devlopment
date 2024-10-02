@AbapCatalog.sqlViewName: 'YOPENBEAM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Facory Beam Print'
define view ZMM_YARN_FACTORY_BEAM_OPEN1
    with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date  as select from ZMM_Yarn_Factory_Beam_OPEN( P_KeyDate: $parameters.P_KeyDate )

{
    Plant,
    Customer,
    sum( MatlWrhsStkQtyInMatlBaseUnit ) as OpeningBalance
} 

where MatlWrhsStkQtyInMatlBaseUnit > 0
   group by 
    Plant,
    Customer
