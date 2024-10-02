@AbapCatalog.sqlViewName: 'YALRYQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Already Con Qty'
define view ZPP_ALREADY_CON_QTY1 as select from ZPP_ALREADY_CON_QTY
{
    key Material,
    key Plant,
    key OrderID,
    MaterialDocument,
    reciepeno,
    MaterialBaseUnit,
    sum(AlreadyQty) as AlreadyQty

} 
 group by 
    Material,
    Plant,
    OrderID,
    MaterialDocument,
    reciepeno,
    MaterialBaseUnit
