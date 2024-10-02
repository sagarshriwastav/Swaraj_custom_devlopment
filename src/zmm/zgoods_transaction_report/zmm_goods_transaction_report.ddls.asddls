@AbapCatalog.sqlViewName: 'YGOODSREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Goods Transaction Report'
define view ZMM_GOODS_TRANSACTION_REPORT
   with parameters
     p_fromdate : abap.dats,
    p_todate   : abap.dats
   as select from I_MaterialDocumentItem_2 as a 
   left outer join I_Product as b on ( b.Product = a.Material )
   
{
  case when a.Material like 'Y%'  then 'YARN' 
      when a.Material like 'FG%'  then 'GREY FABRIC'
      when a.Material like 'FF%' or  a.Material like '776%' then 'FINISH FABRIC'
      when a.Material like 'HUS%' then 'HUSK'
      when a.Material like 'SD%' and a.MaterialBaseUnit = 'KG' then 'DYES CHEMICAL' end as Material,
  a.Plant,
  a.MaterialBaseUnit,
  
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum( case when ( a.DebitCreditCode = 'H' 
  and ( a.GoodsMovementType = '201' or a.GoodsMovementType = '543'  
  or a.GoodsMovementType = '261' ) ) then a.QuantityInBaseUnit  
  when ( a.DebitCreditCode = 'S' 
  and ( a.GoodsMovementType = '202' or a.GoodsMovementType = '544' or  a.GoodsMovementType = '262' ) )
  then -1 * a.QuantityInBaseUnit end )  as ConsumptionQty ,
   
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum( case when a.DebitCreditCode = 'S' and a.GoodsMovementType = '101' and a.OrderID <> '' then a.QuantityInBaseUnit 
  when a.DebitCreditCode = 'H' and a.GoodsMovementType = '102'  and a.OrderID <> '' then -1 * a.QuantityInBaseUnit end ) 
  as  ProductionQty,
  
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum( case when a.DebitCreditCode = 'H' and a.GoodsMovementType = '161' then a.QuantityInBaseUnit  
  when a.DebitCreditCode = 'S' and a.GoodsMovementType = '162' then -1 * a.QuantityInBaseUnit end )
  as PurchaseretunQty,
  
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum( case when a.DebitCreditCode = 'H' and ( a.GoodsMovementType = '601' ) then  a.QuantityInBaseUnit 
  when  a.DebitCreditCode = 'S' and ( a.GoodsMovementType = '602' ) then -1 * a.QuantityInBaseUnit end ) 
  as SalesQty,
  
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum( case when a.DebitCreditCode = 'S' and a.GoodsMovementType = '101' and a.PurchaseOrder <> '' then  a.QuantityInBaseUnit  
  when a.DebitCreditCode = 'H' and a.GoodsMovementType = '102' and a.PurchaseOrder <> '' then - 1 * a.QuantityInBaseUnit end ) 
  as YarnPuchaseQty,
  
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  sum( case when a.DebitCreditCode = 'S' and a.GoodsMovementType = '653'  then  a.QuantityInBaseUnit 
  when a.DebitCreditCode = 'H' and a.GoodsMovementType = '654'  then - 1 * a.QuantityInBaseUnit end ) 
  as YarnSalesQty  // YARNRETURNQTY
  
  
    
}  where ( a.GoodsMovementType = '201' or a.GoodsMovementType = '202'
     or  a.GoodsMovementType = '543' or  a.GoodsMovementType = '544'
      or a.GoodsMovementType = '261' or a.GoodsMovementType = '262' 
      or a.GoodsMovementType = '101' or a.GoodsMovementType = '102'
      or a.GoodsMovementType = '161' or a.GoodsMovementType = '162' 
      or a.GoodsMovementType = '601' or a.GoodsMovementType = '602'
      or a.GoodsMovementType = '653' or a.GoodsMovementType = '654'  ) 
      and ( a.Material like 'Y%' or a.Material like 'FG%' or  a.Material like 'FF%' or  a.Material like 'HUS%' 
       or ( a.Material like 'SD%' and a.MaterialBaseUnit = 'KG' ) ) 
       and b.ProductType <> 'ZDYJ' and b.ProductType <> 'ZFIJ' and b.ProductType <> 'ZGFJ'
       and b.ProductType <> 'ZWRJ' and b.ProductType <> 'ZYRJ'
    and a.PostingDate between $parameters.p_fromdate  and $parameters.p_todate
    
    group by a.Material,
    a.Plant,
    a.PurchaseOrder,
    a.SalesOrder,
    a.MaterialBaseUnit ,
    a.GoodsMovementType
