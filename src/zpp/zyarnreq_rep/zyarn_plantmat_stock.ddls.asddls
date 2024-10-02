@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Plant Mat Stock'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZYARN_PLANTMAT_STOCK as select from I_MaterialStock_2

{
    key Material,
    key Plant   ,  
        MaterialBaseUnit,
        StorageLocation,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        cast( sum( MatlWrhsStkQtyInMatlBaseUnit ) as abap.quan( 13, 3 )  ) as StockQty
          // as StockQty
}    where ( Material like 'Y%' and StorageLocation like 'YRM1'  ) 
      or ( Material like 'S%' and StorageLocation like 'ST01')  
   group by 
        Material,
        Plant,
        StorageLocation,
        MaterialBaseUnit
