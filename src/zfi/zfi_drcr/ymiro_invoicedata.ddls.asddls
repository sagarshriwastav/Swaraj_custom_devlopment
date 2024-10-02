@AbapCatalog.sqlViewName: 'YPSREPORT '
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Miro invoice Data and Tax Data'
define view YMIRO_INVOICEDATA as select from I_SuplrInvcItemPurOrdRefAPI01 as a
 {
    a.SupplierInvoice ,
    a.SupplierInvoiceItem ,
    a.FiscalYear ,
    a.PurchaseOrder,
    a.PurchaseOrderItem,
    sum ( a.QuantityInPurchaseOrderUnit ) as QuantityInPurchaseOrderUnit
    ,
    concat( SupplierInvoice, FiscalYear ) as awkey 
}
where a.SuplrInvcDeliveryCostCndnType is initial
group by 
 a.SupplierInvoice ,
    a.SupplierInvoiceItem ,
    a.FiscalYear ,
    a.PurchaseOrder,
    a.PurchaseOrderItem   ;
