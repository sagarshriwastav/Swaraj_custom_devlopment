@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice tax data Gst'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YINVOICETAXDATA_3 as select from   I_BillingDocumentItem as A  
 left outer join   YCDSData_Taxes as d on A.BillingDocument = d.BillingDocument and A.BillingDocumentItem = d.BillingDocumentItem     
 left outer join   y_gstdatainv as b on A.BillingDocument = b.BillingDocument and A.BillingDocumentItem = b.BillingDocumentItem
   left outer join   I_BillingDocumentItemPrcgElmnt as C on A.BillingDocument = C.BillingDocument and A.BillingDocumentItem = C.BillingDocumentItem     
   and C.ConditionType != 'JTCB' 

left outer join I_BillingDocument as F on A.BillingDocument = F.BillingDocument

left outer join I_PaymentTermsText as G on G.PaymentTerms = F.CustomerPaymentTerms and G.Language = 'E'

left outer join I_ProductValuationBasic as h on h.Product = A.Material and h.ValuationArea = A.Plant 

 {                                                                                       
key A.BillingDocument ,
key A.BillingDocumentItem,
   A.ReferenceSDDocument,
   A.SalesDocument,
   A.SalesDocumentItem,
 d.TransactionCurrency ,
 A.BaseUnit,
 @Semantics.quantity.unitOfMeasure: 'BaseUnit'
 A.BillingQuantity,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 d.TaxableValue  ,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
  b.TaxableValue as taxvalue,
  @Semantics.amount.currencyCode: 'TransactionCurrency'
 C.ConditionAmount,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 case C.ConditionType
  when 'ZFOC' then (d.TaxableValue - (- (C.ConditionAmount ) ) )
  when 'ZEIN' then (d.TaxableValue - (- (C.ConditionAmount ) ) )
  when 'ZAG4' then (d.TaxableValue - C.ConditionAmount )
  when 'ZAG5' then (d.TaxableValue - C.ConditionAmount )
  when 'ZAG6' then (d.TaxableValue - C.ConditionAmount )
  when 'ZFFA' then (d.TaxableValue - C.ConditionAmount )
  when 'ZDIS' then (d.TaxableValue - C.ConditionAmount )
  when 'ZINS' then (d.TaxableValue - C.ConditionAmount )
  when 'ZLDA' then (d.TaxableValue - C.ConditionAmount )
  when 'ZPCA' then (d.TaxableValue - C.ConditionAmount )
  when 'ZDCK' then (d.TaxableValue - C.ConditionAmount )
  when 'ZFDO' then (d.TaxableValue - C.ConditionAmount )
  when 'ZDIN' then (d.TaxableValue - C.ConditionAmount )
  end as TOTALBASICAMOUNT,
 C.ConditionType,
 G.PaymentTermsDescription,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
 h.StandardPrice,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
//( (A.BillingQuantity) * h.StandardPrice ) as 
cast( cast(  A.BillingQuantity  as abap.fltp) * cast( h.StandardPrice as abap.fltp )  as abap.dec( 15, 2) ) as AMOUNT
 
} group by 
A.BillingDocument ,
A.BillingDocumentItem ,
A.SalesDocumentItem,
A.ReferenceSDDocument,
A.SalesDocument,
A.BaseUnit,
C.ConditionType,
d.TransactionCurrency ,
d.TaxableValue ,
C.ConditionAmount,
b.TaxableValue
,
G.PaymentTermsDescription,
h.StandardPrice,
A.BillingQuantity
