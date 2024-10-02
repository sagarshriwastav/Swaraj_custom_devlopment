@AbapCatalog.sqlViewName: 'YGRQTYSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Finish Entry GrQty Sum'
define view ZPP_FINISH_ENTRY_GRQTY_2 as select from ZPP_FINISH_ENTRY_GRQTY
{
    key OrderID,
    MaterialBaseUnit,
    GrQty
}  
    where GrQty > 0
   
   
