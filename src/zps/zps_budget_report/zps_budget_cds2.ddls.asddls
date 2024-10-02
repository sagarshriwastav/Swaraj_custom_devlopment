@AbapCatalog.sqlViewName: 'YPSBUDG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Ps Budget Report'
define view ZPS_BUDGET_CDS2 as select from I_MaterialDocumentItem_2       as c 
                inner join ymseg4 as e on ( e.MaterialDocument = c.MaterialDocument 
                               and e.MaterialDocumentItem = c.MaterialDocumentItem 
                               and e.MaterialDocumentYear = c.MaterialDocumentYear )
{
     key c.PurchaseOrder,
     key c.PurchaseOrderItem,
     key c.MaterialDocument,
     key c.MaterialDocumentItem
}
