@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Opening Closing CUBE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZOPENING_CLOSING_CUBE
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats

  as select from    I_ProductPlantBasic                                   as mat
    left outer join ZOPENING_CLOSING2( P_KeyDate2:$parameters.p_todate  ) as clos on(
      clos.Material  = mat.Product
      and clos.Plant = mat.Plant
    )
    left outer join ZOPENING_CLOSING( P_KeyDate:$parameters.p_fromdate  ) as open on(
      open.Material  = mat.Product
      and open.Plant = mat.Plant
      and open.Batch = clos.Batch
    )

{
  open.CompanyCode,
  open.Material,
  open.Plant,
  open.Batch,
   case when open.MaterialBaseUnit is not initial
      then cast( 'QT'  as abap.unit( 3 )  ) end as MaterialBaseUnit,
  open.MaterialBaseUnit                         as ORGINALUNIT,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   sum(open.MatlWrhsStkQtyInMatlBaseUnit)       as openingquantity,
  
//   clos.Currency as Currency ,
 //  @Semantics.amount.currencyCode: 'Currency'
 //  clos.StockValueInDisplayCurrency as StockValueInDisplayCurrency ,
//   clos.CostEstimate  ,
   
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum(clos.MatlWrhsStkQtyInMatlBaseUnit)       as closing




}
group by
  open.CompanyCode,
  open.Material,
  open.Plant,
  open.Batch,
////  clos.Currency ,
////  clos.StockValueInDisplayCurrency ,
//  clos.Batch,
   open.MaterialBaseUnit
