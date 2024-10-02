@AbapCatalog.sqlViewName: 'YINVPURCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Me2m Report History Invoice'
define view ZMM_ME2M_HISTORY_INV as select from I_PurchaseOrderHistoryAPI01 as e
{

 key e.PurchaseOrder,
   key e.PurchaseOrderItem,
       case when e.DebitCreditCode = 'H' then e.Quantity * -1 else 
       e.Quantity end as Quantity,
       case when e.DebitCreditCode = 'H' then e.InvoiceAmtInCoCodeCrcy * -1 else 
       e.InvoiceAmtInCoCodeCrcy end as   InvoiceAmtInCoCodeCrcy 
}  
  where e.PurchasingHistoryCategory = 'Q'  
      
