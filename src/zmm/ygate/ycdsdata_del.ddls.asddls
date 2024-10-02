@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'cds for delivery data'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Ycdsdata_del as select from I_BillingDocumentItem as a 
                  inner join I_DeliveryDocumentItem as b on ( a.ReferenceSDDocument = b.DeliveryDocument 
                  and a.ReferenceSDDocumentItem  = b.HigherLvlItmOfBatSpltItm  ) 
                  left outer join ZPACKN_CDS as c on b.Batch = c.Batch 
                  left outer join I_BillingDocument as d on ( d.BillingDocument = a.BillingDocument )
                  left outer join I_BillingDocumentPartner as e on ( e.BillingDocument = a.BillingDocument and e.PartnerFunction = 'ZT' )
                  left outer join I_Supplier as f on ( f.Supplier = e.Supplier )
                   { 
   key a.BillingDocument ,     
   key a.BillingDocumentItem ,
   a.BillingQuantityUnit ,
   f.SupplierName as TransporterName,
   d.YY1_LRNumber_BDH,
   @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'      
  sum( b.ActualDeliveryQuantity  ) as delievered_quantity, 
  count( distinct(b.Batch) ) as zpackage ,
   @Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'  
  sum( c.Grosswt  ) as Grosweight      
} group by a.BillingDocument ,
      a.BillingDocumentItem ,
      f.SupplierName,
      a.BillingQuantityUnit,
      d.YY1_LRNumber_BDH
