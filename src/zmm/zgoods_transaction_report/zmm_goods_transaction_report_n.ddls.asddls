@AbapCatalog.sqlViewName: 'ZGOODSREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Goods Transaction Report'
define view ZMM_GOODS_TRANSACTION_REPORT_N 
with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats 
    as select from ZGOODS_TRANSACTION_CDS1 as a 
    left outer join ZGOODS_OPENING_CDS1( p_fromdate:$parameters.p_fromdate ) 
    as OPEN on ( OPEN.Material = a.Material and OPEN.Plant = a.Plant )       
    left outer join ZMM_GOODS_TRANSACTION_REPORT( p_fromdate:$parameters.p_fromdate , p_todate:$parameters.p_todate )
      as b on ( b.Material = a.Material and b.Plant = a.Plant )
    left outer join ZGOODS_CLOSING_CDS1( p_fromdate:$parameters.p_todate ) 
    as close on ( close.Material = a.Material and close.Plant = a.Plant )
{
    key a.Material,
    key a.Plant,   
    b.MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    OPEN.Opening   as OpeningQty,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
    sum(b.ConsumptionQty) as ConsumptionQty,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(b.ProductionQty) as ProductionQty,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(b.PurchaseretunQty) as PurchaseretunQty,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(b.SalesQty) as SalesQty,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(b.YarnPuchaseQty) as YarnPuchaseQty,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    sum(b.YarnSalesQty) as YarnSalesQty,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    close.Opening as ClosingQty
} 
  group by
    a.Material,
    a.Plant,
    b.MaterialBaseUnit,
    OPEN.Opening,
    close.Opening
