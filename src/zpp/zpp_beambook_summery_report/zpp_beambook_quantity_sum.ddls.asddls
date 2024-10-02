@AbapCatalog.sqlViewName: 'YSUQUANTITY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BEAMBOOK_QUANTITY_SUM'
define view ZPP_BEAMBOOK_QUANTITY_SUM as select from ZPP_GREY_GRN_REPORT
{
    Prodorder,
    cast( case when Uom = '' then 'M'  else  Uom end as  abap.unit( 3 ) ) as  Uom ,
   @Semantics.quantity.unitOfMeasure : 'uom'
    sum(Quantity) as Quantity
    
}   group by Prodorder,
             Uom
