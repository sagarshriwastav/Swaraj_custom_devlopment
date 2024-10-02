@AbapCatalog.sqlViewName: 'YDOMESTICPRINT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Delivery Pick Rate'
define view ZPP_DELIVERY_PICK_RATE as select from ZDELIVERY_PICK_RATE_fin
{
    key DeliveryDocument,
    key DELIVERYDOCUMENTITEM,
    Plant,
    Material,
    DeliveryDocumentItemText,
    BaseUnit,
    pick
}
   group by 
    DeliveryDocument,
    DELIVERYDOCUMENTITEM,
    Plant,
    Material,
    DeliveryDocumentItemText,
    BaseUnit,
    pick
