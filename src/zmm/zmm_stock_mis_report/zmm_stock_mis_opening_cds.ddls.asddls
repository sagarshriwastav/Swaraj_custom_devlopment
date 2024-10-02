@AbapCatalog.sqlViewName: 'YOPENING_MIS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_STOCK_MIS_OPENING_CDS'
define view ZMM_STOCK_MIS_OPENING_CDS 
 with parameters
     p_fromdate : abap.dats,
    p_todate   : abap.dats
as select from I_MaterialDocumentItem_2 as a
  left outer join I_Product as b on ( b.Product = a.Material )
  
  {
     b.ProductType,
     a.Plant,
     cast( case when a.MaterialBaseUnit = 'ST' or a.MaterialBaseUnit = 'KG' then 'M'  else  MaterialBaseUnit end as  abap.unit( 3 ) ) as  MaterialBaseUnit ,
     a.PostingDate,
     a.CompanyCodeCurrency,
     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     sum( case when a.GoodsMovementType = '101' or a.GoodsMovementType = '561'
     then a.TotalGoodsMvtAmtInCCCrcy end ) as RECEIPTVALUE,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     sum(case when a.GoodsMovementType = '101' or a.GoodsMovementType = '561' 
     then a.QuantityInBaseUnit end)as Receiptqty, 
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
     sum(case when a.GoodsMovementType = '543' or a.GoodsMovementType = '601' 
     or a.GoodsMovementType = '261'  or a.GoodsMovementType = '201' or a.GoodsMovementType = '221'
     or a.GoodsMovementType = '161'then a.QuantityInBaseUnit  end ) as Issueqty,
     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     sum( case when a.GoodsMovementType = '543' or a.GoodsMovementType = '601' 
     or  a.GoodsMovementType = '261' or a.GoodsMovementType = '201' or  a.GoodsMovementType = '221'
     or a.GoodsMovementType = '161' then 
     a.TotalGoodsMvtAmtInCCCrcy end ) as issuevalue
 
 
 
  } where a.GoodsMovementIsCancelled = '' and ( a.GoodsMovementType = '101' or a.GoodsMovementType = '561' 
         or a.GoodsMovementType = '543'  or a.GoodsMovementType = '601' or a.GoodsMovementType = '261'
         or a.GoodsMovementType = '201' or a.GoodsMovementType = '221' or a.GoodsMovementType = '161' )
         and a.PostingDate between $parameters.p_fromdate  and $parameters.p_todate
   group by b.ProductType,
            a.Plant,
            a.MaterialBaseUnit,
            a.PostingDate,
            a.CompanyCodeCurrency
