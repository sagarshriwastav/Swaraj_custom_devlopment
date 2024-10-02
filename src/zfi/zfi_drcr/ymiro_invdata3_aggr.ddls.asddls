@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice tds aggregation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YMIRO_INVDATA3_AGGR as select from YMIRO_INVOICEDATA3 {
    key PurchaseOrder,   
    CompanyCodeCurrency,
     @DefaultAggregation: #SUM
     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum( Withholding ) as tDX
}
group by PurchaseOrder,   
    CompanyCodeCurrency 
