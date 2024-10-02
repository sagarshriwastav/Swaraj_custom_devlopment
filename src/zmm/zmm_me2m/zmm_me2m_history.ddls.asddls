@AbapCatalog.sqlViewName: 'YPURCHASEORDER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Me2m Report History'
define view ZMM_ME2M_HISTORY as select from I_PurchaseOrderHistoryAPI01 as e  
      inner join ymseg4 as a on ( a.MaterialDocument = e.PurchasingHistoryDocument 
                                  and a.MaterialDocumentItem = e.PurchasingHistoryDocumentItem 
                                  and a.MaterialDocumentYear = e.PurchasingHistoryDocumentYear )
 
{
   key e.PurchaseOrder,
   key e.PurchaseOrderItem,
       sum(e.Quantity) as Quantity,
       sum(e.PurchaseOrderAmount) as  PurchaseOrderAmount
}  
  where e.GoodsMovementType = '101'  
  group by 
       e.PurchaseOrder,
       e.PurchaseOrderItem
