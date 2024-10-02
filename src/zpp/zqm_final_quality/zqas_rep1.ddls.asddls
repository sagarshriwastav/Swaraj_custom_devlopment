@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Qas Rep'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZQAS_REP1 as select from I_MaterialStock_2 as a
inner join  I_ProductDescription as b on (a.Material
 = b.Product  and b.Language = $session.system_language  )

{
 key a.Plant ,
 key a.Material,
 key a.Batch ,
 a.SDDocument,
 a.SDDocumentItem,
 a.StorageLocation ,
 a.MaterialBaseUnit ,
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 sum( a.MatlWrhsStkQtyInMatlBaseUnit )  as StockQty,
 b.ProductDescription 

    
}
 group by 
 a.Plant ,
 a.Material,
 a.Batch ,
 a.SDDocument,
 a.SDDocumentItem,
 a.StorageLocation ,
 a.MaterialBaseUnit ,
 b.ProductDescription
