@AbapCatalog.sqlViewName: 'YQUANTIT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BEAMBOOK_QUANTITY_CDS'
define view ZPP_BEAMBOOK_QUANTITY_CDS as select from ZPP_BEAMBOOK_QUANTITY_SUM
{
    Prodorder,
    Uom,
    @Semantics.quantity.unitOfMeasure : 'uom'
    sum(Quantity) as Quantity
    
} group by Prodorder,
           Uom
