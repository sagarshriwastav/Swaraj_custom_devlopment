@AbapCatalog.sqlViewName: 'YQUANTITYFABRIC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_OPENING_FABRICPRINT_MM'
define view ZPP_OPENING_FABRICPRINT_MM1 
with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
    as select from ZPP_OPENING_FABRICPRINT_MM( p_fromdate: $parameters.p_fromdate , p_todate: $parameters.p_todate )
{
    key Material,
    key Plant,
    key Batch,
    Partyname,
    openingquantity,
    BillOfMaterialItemUnit,
    BillOfMaterialItemQuantity,
    as1,
    fltp_to_dec( as1 as abap.dec(10,3) ) as dec1_10_0
}
