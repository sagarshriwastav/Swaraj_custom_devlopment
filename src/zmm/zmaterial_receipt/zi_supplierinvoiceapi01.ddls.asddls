@AbapCatalog.sqlViewName: 'YSUPLIER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Supplier Invoice Report'
define view ZI_SupplierInvoiceAPI01 as select from I_PurchaseOrderHistoryAPI01 as b 
left outer join I_SupplierInvoiceAPI01 as a on ( a.SupplierInvoice = b.PurchasingHistoryDocument
                                                         )
{
    b.ReferenceDocument,
    b.ReferenceDocumentItem,
    b.PurchasingHistoryDocument ,
    b.PurchasingHistoryDocumentItem ,
    b.InvoiceAmtInCoCodeCrcy ,
    a.SupplierInvoiceStatus ,
    a.CompanyCode,
    a.FiscalYear,
    a.PostingDate ,
    a.SupplierInvoice,
    a.SupplierPostingLineItemText,
    b.PurchaseOrder,
    b.PurchaseOrderItem,
    a.SupplierInvoiceIDByInvcgParty,
    a.DocumentHeaderText,
    a.InvoiceReference,
    a.DocumentDate,
    b.PurchaseOrderAmount
  
    
}
 where 
   a.ReverseDocument = '' and a.ReverseDocumentFiscalYear = '0000'
   and b.PurchasingHistoryCategory <> 'E'  and b.PurchasingHistoryCategory <> 'O' and   b.PurchasingHistoryCategory <> 'N'
   group by 
    b.ReferenceDocument,
    b.ReferenceDocumentItem,
    b.PurchasingHistoryDocument ,
    b.PurchasingHistoryDocumentItem ,
    b.InvoiceAmtInCoCodeCrcy ,
    b.PurchasingHistoryDocument,
    a.SupplierInvoiceStatus ,
    a.PostingDate ,
    a.SupplierInvoice,
    a.CompanyCode,
    a.FiscalYear,
    a.SupplierPostingLineItemText,
    b.PurchaseOrder,
    b.PurchaseOrderItem,
    a.SupplierInvoiceIDByInvcgParty,
    a.DocumentHeaderText,
    a.InvoiceReference,
    a.DocumentDate,
    b.PurchaseOrderAmount
    
   
