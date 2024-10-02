@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Aggregate po and invoice data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Y_PMR_MM2
  as select from    Y_PMR_MM1           as A
    left outer join YMIRO_INVDATA3_AGGR as B on A.PurchaseOrder = B.PurchaseOrder
    left outer join ZPMR4               as C on A.PurchaseOrder = C.PurchaseOrder
{
  key A.PurchaseOrder,
      //    AccountAssignmentNumber,
      A.WBSElementInternalID,
      A.ConditionCurrency,
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      sum(A.taxamount)         as Taxamount,
      //    CreationDate,
      A.CompanyCodeCurrency,
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      sum( A.INV_AMOUNTIN1 )   as InvoiceAmt,
      //     TransactionCurrency,
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      sum( A.Pogrossamount )   as Pogrossamt,
      //    Currency,
      @DefaultAggregation: #SUM
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      sum( A.Poadvanceamount ) as AdvancePoamount,
      @Semantics.amount.currencyCode: 'ConditionCurrency'
      B.tDX,
      C.CreationDate,
      C.Supplier,
      C.SupplierName
}
group by
  A.PurchaseOrder,
  A.ConditionCurrency,
  A.WBSElementInternalID,
  A.CompanyCodeCurrency,
  B.tDX,
  C.CreationDate,
  C.Supplier,
  C.SupplierName
