@AbapCatalog.viewEnhancementCategory: [#NONE]

@Metadata.ignorePropagatedAnnotations: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Advance amount cds view for po'
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Y_PMR_ADAMT as select from I_PurchaseOrderItemAPI01 as a 
left outer join I_PurchaseOrderHistoryAPI01 as b 
    on a.PurchaseOrder = b.PurchaseOrder and a.PurchaseOrderItem  = b.PurchaseOrderItem 
    and b.PurchasingHistoryCategory =  'A' {
     a.PurchaseOrder ,
     a.PurchaseOrderItem ,
     b.Currency ,
   @EndUserText.label: 'Amount'
@Semantics.amount.currencyCode: 'Currency'
    sum( b.PurchaseOrderAmount ) as Poadvanceamount 
     
    
}
where b.PurchaseOrderAmount is not initial 
group by 
    a.PurchaseOrder ,
     a.PurchaseOrderItem ,
     b.Currency 
     
