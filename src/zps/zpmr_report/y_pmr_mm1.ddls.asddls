@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ps pmr report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Y_PMR_MM1 as select from I_PurOrdAccountAssignmentAPI01 as a inner join 
I_PurOrdItmPricingElementAPI01 as b  on a.PurchaseOrder = b.PurchaseOrder
and a.PurchaseOrderItem = b.PurchaseOrderItem 
 and b.ConditionType  = 'ZJEX' 
 left outer join I_PurchaseOrderAPI01 as c  on  a.PurchaseOrder = c.PurchaseOrder

left outer join YMIRO_INVOICEDATA2 as z on a.PurchaseOrder = z.PurchaseOrder
 and a.PurchaseOrderItem = z.PurchaseOrderItem
  left outer join YPO_CONDITIONDATA as D on a.PurchaseOrder = D.PurchaseOrder
                                  and a.PurchaseOrderItem = D.PurchaseOrderItem
  left outer join Y_PMR_ADAMT as e on a.PurchaseOrder = e.PurchaseOrder
                                  and a.PurchaseOrderItem = e.PurchaseOrderItem
 

  { 
 key a.PurchaseOrder ,
 key a.PurchaseOrderItem,
 a.AccountAssignmentNumber,
   a.WBSElementInternalID,
 b.ConditionCurrency ,
// @Semantics.amount.currencyCode: 'ConditionCurrency' 
// sum( b.ConditionAmount ) as taxamount ,
 @DefaultAggregation: #SUM
 @Semantics.amount.currencyCode: 'ConditionCurrency' 
 b.ConditionAmount as taxamount ,
// c.Supplier,
 c.CreationDate,
// z.SupplierInvoice ,
 z.CompanyCodeCurrency ,
// z.compcurrwtax ,
//  @Semantics.amount.currencyCode: 'compcurrwtax' 
// z.withholdingtax ,
// 
 @DefaultAggregation: #SUM
 @Semantics.amount.currencyCode: 'CompanyCodeCurrency'  
 sum( z.AMOUNTIN ) as INV_AMOUNTIN1  ,
 D.TransactionCurrency ,
  @DefaultAggregation: #SUM
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 D.GROSSAMT as Pogrossamount ,
 e.Currency ,

 @Semantics.amount.currencyCode: 'Currency'
 e.Poadvanceamount  as Poadvanceamount

    
}
group by 
 a.PurchaseOrder ,
 a.PurchaseOrderItem,
 a.AccountAssignmentNumber,
 a.WBSElementInternalID,
 b.ConditionCurrency ,
 b.ConditionAmount ,
// @Semantics.amount.currencyCode: 'ConditionCurrency' 7
// sum( b.ConditionAmount ) as taxamount ,
 c.Supplier,
// z.SupplierInvoice ,
// z.AMOUNTIN ,
 c.CreationDate ,
 D.GROSSAMT,
  z.CompanyCodeCurrency , 
  D.TransactionCurrency ,
  e.Currency ,
  e.Poadvanceamount 
//  z.withholdingtax ,
//  z.compcurrwtax 
// e.Currency,
// @Semantics.amount.currencyCode: 'Currency' 
// e.PurchaseOrderAmount ,
// e.PostingDate ,
//f.FiscalYear ,
// g.SupplierInvoice,
// g.DocumentCurrency,
// g.InvoiceGrossAmount
