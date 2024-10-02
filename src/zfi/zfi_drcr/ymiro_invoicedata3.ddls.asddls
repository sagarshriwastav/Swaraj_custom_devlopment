@AbapCatalog.sqlViewName: 'ZINVOICE1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'invoice data'
define view YMIRO_INVOICEDATA3
  as select distinct from    YMIRO_INVOICEDATA         as a
    left outer join I_OperationalAcctgDocItem as b on  a.awkey                        = b.OriginalReferenceDocument
                                                   and b.TransactionTypeDetermination = 'KBS'
  //    and a.PurchaseOrder = b.PurchasingDocument
  //    and a.PurchaseOrderItem = b.PurchasingDocumentItem
  //    left outer join I_OperationalAcctgDocItem as c on
  //                c.AccountingDocument = b.AccountingDocument and  c.TransactionTypeDetermination =  'KBS'

{
  key  a.PurchaseOrder,
//           a.PurchaseOrderItem ,
       a.SupplierInvoice,
       //    a.SupplierInvoiceItem ,
       //    a.FiscalYear,
       //    a.QuantityInPurchaseOrderUnit ,
       //    a.awkey ,
       b.AccountingDocument,
       b.AccountingDocumentCategory,
       //    b.AccountingDocumentItem,
       //    b.TaxItemAcctgDocItemRef ,
       b.CompanyCodeCurrency,
       @DefaultAggregation: #SUM
       @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
       //    min( b.WithholdingTaxAmount ) as Withholding
       b.WithholdingTaxAmount as Withholding
       //    d.CompanyCodeCurrency as compcurrwtax ,
       //    @DefaultAggregation: #SUM
       //   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
       //   sum( d.WithholdingTaxAmount ) as withholdingtax
}
//group by
//  a.SupplierInvoice,
//  //    a.SupplierInvoiceItem ,
//  //    a.FiscalYear,
//  a.PurchaseOrder,
//  //    a.PurchaseOrderItem ,
//  //    a.QuantityInPurchaseOrderUnit ,
//  //    a.awkey ,
//  b.AccountingDocument,
//  b.AccountingDocumentCategory,
//  //    b.AccountingDocumentItem,
//  //    b.TaxItemAcctgDocItemRef ,
//  b.CompanyCodeCurrency
