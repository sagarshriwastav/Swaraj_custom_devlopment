@AbapCatalog.sqlViewName: 'ZDELIEVERY1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delievery'
define view YDELI_DATA as select from I_DeliveryDocumentItem as a 
inner join I_DeliveryDocument as b on a.DeliveryDocument  = b.DeliveryDocument
inner join I_ProductText as c on ( a.Material  = c.Product and c.Language = 'E' )
inner join YCDS_BILDATA     as d on (a.DeliveryDocument = d.ReferenceSDDocument
                                           and a.DeliveryDocumentItem  = d.ReferenceSDDocumentItem  )
left outer join I_Customer            as e on ( b.ShipToParty = e.Customer )
left outer join I_DeliveryDocumentItem as f on (  a.DeliveryDocument = f.DeliveryDocument 
                                           and a.DeliveryDocumentItem = f.HigherLvlItmOfBatSpltItm )
                                           
 {
    
   key a.DeliveryDocument,
    key a.DeliveryDocumentItem,
    a.SDDocumentCategory,
    a.TransactionCurrency,
    a.DeliveryDocumentItemCategory,
    a.SalesDocumentItemType,  
    a.DistributionChannel,
    a.Division,
    a.SalesGroup,
    a.SalesOffice,   
    a.Material,
    a.Product, 
    a.OriginallyRequestedMaterial,
    a.InternationalArticleNumber,
    a.Batch, 
    a.MaterialGroup,
    a.ProductGroup,  
    a.Plant,
    a.Warehouse,
    a.StorageLocation, 
    a.HigherLevelItem,
    a.HigherLvlItmOfBatSpltItm,
    a.ActualDeliveryQuantity,
    a.QuantityIsFixed,
    a.OriginalDeliveryQuantity,
    a.DeliveryQuantityUnit,
    a.ActualDeliveredQtyInBaseUnit,
    a.BaseUnit,
    a.DeliveryToBaseQuantityDnmntr,
    a.DeliveryToBaseQuantityNmrtr,
    a.ProductAvailabilityDate,
    a.ProductAvailabilityTime,
    a.DeliveryGroup,
    a.ItemGrossWeight,
    a.ItemNetWeight,
    a.DeliveryQuantityUnit as ItemWeightUnit,
    a.ItemVolume,
    a.ItemVolumeUnit,   
    a.GoodsMovementReasonCode,    
    a.TransportationGroup,    
    a.OrderID,
    a.OrderItem, 
    a.DeliveryDocumentItemBySupplier,
    a.ReferenceSDDocument,
    a.ReferenceSDDocumentItem,
    a.ReferenceSDDocumentCategory,   
    a.OriginSDDocument,
   
    b.SoldToParty ,
    b.ShipToParty ,
    c.ProductName as material_description ,
    d.BillingDocument as invoice,
    e.CustomerName  ,
 @Semantics.quantity.unitOfMeasure: 'BaseUnit'      
 sum( f.ActualDeliveryQuantity  ) as delievered_quantity,   
 count( distinct(f.Batch) ) as zpackage
     
}
where 
  ( a.Batch is initial or a.Batch = ' ' or a.Batch is null  )
group by a.DeliveryDocument,
     a.DeliveryDocumentItem,
    a.SDDocumentCategory,
    a.TransactionCurrency,
    a.DeliveryDocumentItemCategory,
    a.SalesDocumentItemType,  
    a.DistributionChannel,
    a.Division,
    a.SalesGroup,
    a.SalesOffice,   
    a.Material,
    a.Product, 
    a.OriginallyRequestedMaterial,
    a.InternationalArticleNumber,
    a.Batch, 
    a.MaterialGroup,
    a.ProductGroup,  
    a.Plant,
    a.Warehouse,
    a.StorageLocation, 
    a.HigherLevelItem,
    a.HigherLvlItmOfBatSpltItm,
    a.ActualDeliveryQuantity,
    a.QuantityIsFixed,
    a.OriginalDeliveryQuantity,
    a.DeliveryQuantityUnit,
    a.ActualDeliveredQtyInBaseUnit,
    a.BaseUnit,
    a.DeliveryToBaseQuantityDnmntr,
    a.DeliveryToBaseQuantityNmrtr,
    a.ProductAvailabilityDate,
    a.ProductAvailabilityTime,
    a.DeliveryGroup,
    a.ItemGrossWeight,
    a.ItemNetWeight,
    a.ItemWeightUnit,
    a.ItemVolume,
    a.ItemVolumeUnit,   
    a.GoodsMovementReasonCode,    
    a.TransportationGroup,    
    a.OrderID,
    a.OrderItem, 
    a.DeliveryDocumentItemBySupplier,
    a.ReferenceSDDocument,
    a.ReferenceSDDocumentItem,
    a.ReferenceSDDocumentCategory,   
    a.OriginSDDocument,
    a.CreditRelatedPrice,  
    b.SoldToParty ,
    b.ShipToParty ,
    c.ProductName ,
    d.BillingDocument,
    e.CustomerName  ;



