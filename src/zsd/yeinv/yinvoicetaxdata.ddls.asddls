@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice tax data Gst'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity yinvoicetaxdata as select from  YINVOICETAXDATA_3 as a 
              left outer join I_DeliveryDocument             as del         on a.ReferenceSDDocument = del.DeliveryDocument 
              left outer join I_SalesDocument               as Sales        on a.SalesDocument   =  Sales.SalesDocument 
              left outer join I_SalesDocumentPartner    as Agent      on ( Agent.SalesDocument =  a.SalesDocument  
                                                                           and Agent.PartnerFunction = 'ZA' ) 
             left outer join I_Supplier            as AgentName      on ( AgentName.Supplier = Agent.Supplier )                                                              
 {                                                                                       
key a.BillingDocument ,
key a.BillingDocumentItem,
 a.TransactionCurrency ,
 a.BaseUnit,
 @Semantics.quantity.unitOfMeasure: 'BaseUnit'
 sum(a.BillingQuantity) as BillingQuantity,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 a.TaxableValue  ,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
  a.taxvalue,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
 sum( a.ConditionAmount ) as TotalInvoiceValue ,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
  sum(a.TOTALBASICAMOUNT) as TOTALBASICAMOUNT,
// C.ConditionType,
 a.PaymentTermsDescription,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 a.StandardPrice,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
//( (A.BillingQuantity) * h.StandardPrice ) as 
 a.AMOUNT,
 del.ActualGoodsMovementDate,
 Sales.RequestedDeliveryDate,
   case when dats_days_between( del.ActualGoodsMovementDate , Sales.RequestedDeliveryDate ) < 0 then
    ( dats_days_between( del.ActualGoodsMovementDate , Sales.RequestedDeliveryDate ) ) * -1 else 
     dats_days_between( del.ActualGoodsMovementDate , Sales.RequestedDeliveryDate ) end as DelayDays,
  AgentName.SupplierName   
     
 
} group by 
a.BillingDocument ,
a.BillingDocumentItem ,
a.BaseUnit,
//a.BillingQuantity,
//C.ConditionType,
a.TransactionCurrency ,
a.taxvalue,
a.TaxableValue
,
a.PaymentTermsDescription,
a.StandardPrice,
//a.TOTALBASICAMOUNT,
a.AMOUNT,
del.ActualGoodsMovementDate,
Sales.RequestedDeliveryDate,
AgentName.SupplierName
//A.BillingQuantity
