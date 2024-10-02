//@AbapCatalog.sqlViewName: 'YQUANTITYOPENING'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'ZOPENING_CLOSING_QTY'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Opening Closing CUBE'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZOPENING_CLOSING_QTY 
with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats

  as select from    I_ProductPlantBasic                                                                          as mat
    left outer join ZOPENING_CLOSING_CUBE( p_fromdate: $parameters.p_fromdate , p_todate: $parameters.p_todate ) as A on(
      A.Material  = mat.Product
      and A.Plant = mat.Plant )
{
    key A.Batch,
    A.CompanyCode,
    A.Material,
    A.Plant,
     cast( 'M' as abap.unit( 3 ) ) as MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(A.openingquantity) as openingquantity,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(A.closing) as closing
      
}group by A.Batch,
          A.CompanyCode,
          A.Material,
          A.Plant
          
