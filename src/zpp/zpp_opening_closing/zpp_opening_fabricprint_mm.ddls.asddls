@AbapCatalog.sqlViewName: 'YBILLINGQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_OPENING_FABRICPRINT_MM'
define view ZPP_OPENING_FABRICPRINT_MM 
with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
as select from ZOPENING_CLOSING_CUBE2( p_fromdate: $parameters.p_fromdate , p_todate: $parameters.p_todate )
{
    key Material,
    key Plant,
    key Batch,
    Partyname,
    openingquantity,
    BillOfMaterialItemUnit,
    BillOfMaterialItemQuantity,
   ( cast(BillOfMaterialItemQuantity as abap.fltp )
                 / ( cast( 100  as abap.fltp )) 
                 * cast(openingquantity as abap.fltp )  
   )  as as1
    
}
