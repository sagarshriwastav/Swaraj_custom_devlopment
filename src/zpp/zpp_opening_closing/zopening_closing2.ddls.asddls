@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Opening Closing CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZOPENING_CLOSING2
    with parameters 
    P_KeyDate2 : vdm_v_key_date
  as select from I_MaterialStock_2 as a
left outer join I_Product as B on ( B.Product = a.Material )
//left outer join I_StockQuantityCurrentValue_2( P_DisplayCurrency:'INR' ) as C on ( C.Product = a.Material and C.Plant = a.Plant and C.Batch = a.Batch and C.StorageLocation = a.StorageLocation and C.InventoryStockType = a.InventoryStockType and C.InventorySpecialStockType = a.InventorySpecialStockType and C.ValuationAreaType = '1' )

{
  a.CompanyCode ,
  a.Plant       ,
  a.Material    ,
  a.Batch       ,
 // a.CostEstimate as clos_CostEstimate  ,
  B.BaseUnit as MaterialBaseUnit ,
//  a.MatlDocLatestPostgDate,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum(a.MatlWrhsStkQtyInMatlBaseUnit) as MatlWrhsStkQtyInMatlBaseUnit 
  
//  C.Currency ,
//  @Semantics. amount.currencyCode: 'Currency'
 //  (C.StockValueInDisplayCurrency ) as StockValueInDisplayCurrency
  
  
} where a.MatlDocLatestPostgDate <= $parameters.P_KeyDate2
     and a.Material is not initial // and C.StockValueInDisplayCurrency is not initial
  group by 
  a.CompanyCode ,
  a.Plant       ,
  a.Material    ,
  a.Batch       ,
  B.BaseUnit
//  a.CostEstimate  
//  a.MatlDocLatestPostgDate ,
//  a.MatlWrhsStkQtyInMatlBaseUnit ,
//   C.Currency ,
 //  C.StockValueInDisplayCurrency 
  // a.MatlWrhsStkQtyInMatlBaseUnit,
  

 