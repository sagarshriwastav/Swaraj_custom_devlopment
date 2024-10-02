@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'For Other Charges and Gst Data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_TAXDATA2 as select from YMIRO_INVOICEDATA as a 
left outer join I_OperationalAcctgDocItem as b 
    on a.awkey = b.OriginalReferenceDocument and a.PurchaseOrder = b.PurchasingDocument 
    and a.PurchaseOrderItem = b.PurchasingDocumentItem 
    left outer join I_OperationalAcctgDocItem as c on c.TaxItemAcctgDocItemRef = b.TaxItemAcctgDocItemRef 
               and c.AccountingDocument = b.AccountingDocument  and ( c.TransactionTypeDetermination = 'JII' or
                                            c.TransactionTypeDetermination = 'JIC' or c.TransactionTypeDetermination = 'JIS' )  
          {
    a.SupplierInvoice,
    a.SupplierInvoiceItem,
    a.FiscalYear,
    a.PurchaseOrder,
    a.PurchaseOrderItem,
//    QuantityInPurchaseOrderUnit,
    a.awkey
}
