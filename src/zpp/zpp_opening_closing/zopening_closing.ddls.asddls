@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Opening Closing CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZOPENING_CLOSING
    with parameters 
    P_KeyDate : vdm_v_key_date
  as select from I_MaterialStock_2 as a
//left outer join I_Product as B on ( B.Product = a.Material )
//left outer join I_MaterialDocumentItem_2 as C on ( C.Batch = a.Batch )// and C.Material = a.Material )

{
  a.CompanyCode ,
  a.Plant       ,
  a.Material    ,
  a.Batch       ,
//  a.CostEstimate as OPEN_CostEstimate ,
  a.MaterialBaseUnit ,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   
 sum(a.MatlWrhsStkQtyInMatlBaseUnit ) as MatlWrhsStkQtyInMatlBaseUnit 
//     a.MatlDocLatestPostgDate ,
//
//  C.Currency ,
//  @Semantics. amount.currencyCode: 'Currency'
//  (C.StockValueInDisplayCurrency ) as StockValueInDisplayCurrency

  
 
} where a.MatlDocLatestPostgDate < $parameters.P_KeyDate
     and a.Material is not initial //and C.GoodsMovementIsCancelled = ''
     
  group by 
  a.CompanyCode ,
  a.Plant       ,
  a.Material    ,
  a.Batch       ,
 // a.CostEstimate ,
//  C.StockValueInDisplayCurrency ,
//  C.Currency ,
  a.MaterialBaseUnit

 