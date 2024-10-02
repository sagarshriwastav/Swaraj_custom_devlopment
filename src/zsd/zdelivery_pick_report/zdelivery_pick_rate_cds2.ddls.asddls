@AbapCatalog.sqlViewName: 'YPICKRATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Delivery Pick Rate'
define view ZDELIVERY_PICK_RATE_cds2 as select from ZDELIVERY_PICK_RATE
 
 
{
    key DeliveryDocument,
    key DELIVERYDOCUMENTITEM,
    Plant,
    Material,
    DeliveryDocumentItemText,
    BaseUnit,
    sum( DELIVERY_QTY) as DeliveryQty,
    TransactionCurrency,
    sum( amt ) as PickRAteAmt
}
   group by 
   
     DeliveryDocument,
     DELIVERYDOCUMENTITEM,
    Plant,
    Material,
    DeliveryDocumentItemText,
    BaseUnit,
    TransactionCurrency
