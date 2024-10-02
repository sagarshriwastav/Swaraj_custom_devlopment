@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'TAX DATA 4 SUPPLIER INVOICE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZMM_TAXDATA1 as select from YMIRO_INVOICEDATA as a
left outer join I_OperationalAcctgDocItem as b 
    on a.awkey = b.OriginalReferenceDocument and a.PurchaseOrder = b.PurchasingDocument 
    and a.PurchaseOrderItem = b.PurchasingDocumentItem 
    left outer join I_OperationalAcctgDocItem as c on c.TaxItemAcctgDocItemRef = b.TaxItemAcctgDocItemRef 
               and c.AccountingDocument = b.AccountingDocument  and ( c.TransactionTypeDetermination = 'JII' or c.TransactionTypeDetermination = 'JIC' or c.TransactionTypeDetermination = 'JIS' )  
   left outer join I_OperationalAcctgDocItem as d on d.TaxItemAcctgDocItemRef = b.TaxItemAcctgDocItemRef 
               and d.AccountingDocument = b.AccountingDocument  and
                d.TaxBaseAmountInCoCodeCrcy is not initial and 
                ( d.TransactionTypeDetermination = 'JII' or d.TransactionTypeDetermination = 'JIC'  )  
     
                 {
 key  a.PurchaseOrder ,
 key  a.PurchaseOrderItem ,    
    a.SupplierInvoice,
    a.SupplierInvoiceItem ,
    a.FiscalYear,
//    a.QuantityInPurchaseOrderUnit ,
    a.awkey ,
    b.AccountingDocument ,
    b.AccountingDocumentCategory ,
    b.AccountingDocumentItem, 
    b.TaxItemAcctgDocItemRef ,
    c.CompanyCodeCurrency ,    
    @DefaultAggregation: #SUM
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'    
    sum( c.AmountInBalanceTransacCrcy ) as AMOUNTIN 
    ,       
      @Semantics.amount.currencyCode: 'CompanyCodeCurrency'    
    d.TaxBaseAmountInCoCodeCrcy  as taxable_amount   
}
group by 
    a.SupplierInvoice,
    a.SupplierInvoiceItem ,
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
    ,
    d.TaxBaseAmountInCoCodeCrcy
