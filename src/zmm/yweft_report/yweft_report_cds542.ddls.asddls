@AbapCatalog.sqlViewName: 'YWEFTCDS542'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Weft Report'
define view YWEFT_REPORT_cds542 as select from I_MaterialDocumentItem_2 
{
    key PurchaseOrder,
    key PurchaseOrderItem,
    key Batch,
        Material,
        Plant,
        MaterialBaseUnit,
        sum(QuantityInEntryUnit) as QuantityInEntryUnit
        
}  where GoodsMovementType = '542' and DebitCreditCode = 'S'
   group by  
     PurchaseOrder,
     PurchaseOrderItem,
     Batch,
     Material,
     MaterialBaseUnit,
     Plant
                                                              
