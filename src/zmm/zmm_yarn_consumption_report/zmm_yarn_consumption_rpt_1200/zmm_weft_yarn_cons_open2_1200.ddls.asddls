@AbapCatalog.sqlViewName: 'YWEFTYARN1200'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Weft Yarn Consumption Report'
define view ZMM_WEFT_YARN_CONS_OPEN2_1200 
  with parameters
    @Consumption.hidden: true
    @Environment.systemField: #SYSTEM_DATE
    P_KeyDate : vdm_v_key_date 
    as select from ZMM_WEFT_YARN_CONSUM_OPEN_1200( P_KeyDate: $parameters.P_KeyDate )
{
    key Material,
    key Plant,   
    key Batch,
    substring(Supplier,4,7) as Supplier,
    MaterialBaseUnit,
    SDDocument,
    SDDocumentItem,
    sum( MatlWrhsStkQtyInMatlBaseUnit ) as OpeningBalance
}  
where MatlWrhsStkQtyInMatlBaseUnit > 0
   group by 
    Material,
    Plant,
    Batch,
    Supplier,
    SDDocument,
    SDDocumentItem,
    MaterialBaseUnit
