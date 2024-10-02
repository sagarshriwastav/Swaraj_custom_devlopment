@AbapCatalog.sqlViewName: 'ZINVOICE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'invoice data'
define view YMIRO_INVOICEDATA2 as select from YMIRO_INVOICEDATA as a
left outer join I_OperationalAcctgDocItem as b 
    on a.awkey = b.OriginalReferenceDocument and a.PurchaseOrder = b.PurchasingDocument 
    and a.PurchaseOrderItem = b.PurchasingDocumentItem 
    left outer join I_OperationalAcctgDocItem as c on c.TaxItemAcctgDocItemRef = b.TaxItemAcctgDocItemRef 
               and c.AccountingDocument = b.AccountingDocument 
          
                 {
 key  a.PurchaseOrder ,
 key  a.PurchaseOrderItem ,    
    a.SupplierInvoice,
//    a.SupplierInvoiceItem ,
    a.FiscalYear,
    a.QuantityInPurchaseOrderUnit ,
    a.awkey ,
    b.AccountingDocument ,
    b.AccountingDocumentCategory ,
    b.AccountingDocumentItem, 
    b.TaxItemAcctgDocItemRef ,
    c.CompanyCodeCurrency , 
    @DefaultAggregation: #SUM
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'    
    sum( c.AmountInBalanceTransacCrcy ) as AMOUNTIN 
}
group by 
    a.SupplierInvoice,
//    a.SupplierInvoiceItem ,
    a.FiscalYear,
    a.PurchaseOrder ,
    a.PurchaseOrderItem ,
    a.QuantityInPurchaseOrderUnit ,
    a.awkey ,
    b.AccountingDocument ,
    b.AccountingDocumentCategory ,
    b.AccountingDocumentItem,
    b.TaxItemAcctgDocItemRef , 
    c.CompanyCodeCurrency 
//    d.CompanyCodeCurrency
