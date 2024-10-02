@AbapCatalog.sqlViewName: 'YPSBUD2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Ps Budget Report'
define view ZPS_BUDGET_CDS3 as select from  I_PurOrdAccountAssignmentAPI01 as a 
     left outer join ZPS_BUDGET_CDS2   as c on  c.PurchaseOrder     = a.PurchaseOrder
                                                        and c.PurchaseOrderItem = a.PurchaseOrderItem 


{
    key a.PurchaseOrder,
    key a.PurchaseOrderItem,
    key c.MaterialDocument,
    key c.MaterialDocumentItem
}
