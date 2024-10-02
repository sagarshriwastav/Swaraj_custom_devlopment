@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Matage CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZMATAGE_REP_CDS 
with parameters p_budat:abap.dats,
                RQTY:abap.int4 ,
                RQTY1:abap.int4, 
                RQTY2:abap.int4,
                RQTY3:abap.int4,
                RQTY4:abap.int4
as select from I_MaterialDocumentItem_2 as A
inner join zmage_order_dt_cds as B on (A.Plant = B.plant and A.Material = B.material 
                                       and A.StorageLocation = B.StorageLocation and
                                       A.Batch = B.BATCH )

{
    
  key A.Plant as plant,
  key A.Material as material,
  key A.StorageLocation as StorageLocation,
  key A.MaterialBaseUnit as MaterialBaseUnit,
  key A.Batch as BATCH,
      A.CompanyCodeCurrency,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  cast( sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat )  between 0   and $parameters.RQTY  
   and A.DebitCreditCode = 'S' and A.GoodsMovementType <> '303'
   and A.QuantityInBaseUnit > 0 then  A.QuantityInBaseUnit 
   else 0 end ) as abap.quan( 13, 3 ) )  as  QTY  ,
 
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 cast( sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY  and dats_days_between( B.POSTINGDATE, $parameters.p_budat ) <= $parameters.RQTY1 
  and  A.DebitCreditCode = 'S'  and A.GoodsMovementType <> '303' and A.QuantityInBaseUnit > 0
  then A.QuantityInBaseUnit 
  else 0 end ) as abap.quan( 13, 3 ) )  as QTY1 ,
  
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  cast( sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY1 and dats_days_between( B.POSTINGDATE, $parameters.p_budat ) <= $parameters.RQTY2 
  and  A.DebitCreditCode = 'S'  and A.GoodsMovementType <> '303' 
  and A.QuantityInBaseUnit > 0 then A.QuantityInBaseUnit
  else 0 end ) as abap.quan( 13, 3 ) )  as QTY2 ,
  
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  cast( sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY2 and dats_days_between( B.POSTINGDATE, $parameters.p_budat ) <= $parameters.RQTY3 
  and  A.DebitCreditCode = 'S' and A.GoodsMovementType <> '303'  and A.QuantityInBaseUnit > 0 
  then A.QuantityInBaseUnit   
  else  0 end ) as abap.quan( 13, 3 ) ) as QTY3 ,


   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  cast(sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY3 and dats_days_between( B.POSTINGDATE, $parameters.p_budat ) <= $parameters.RQTY4 
   and  A.DebitCreditCode = 'S'  and A.GoodsMovementType <> '303' and A.QuantityInBaseUnit > 0 
   then A.QuantityInBaseUnit 
      else 0 end ) as abap.quan( 13, 3 ) ) as QTY4 ,
  
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  cast(sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY4 and A.DebitCreditCode = 'S'  and A.GoodsMovementType <> '303' 
  and A.QuantityInBaseUnit > 0 then A.QuantityInBaseUnit  
  else 0 end ) as abap.quan( 13, 3 ) ) as QTY5,
  
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 cast(sum( case when A.DebitCreditCode = 'H' then A.QuantityInBaseUnit  else 0 end   ) as abap.quan( 13, 3 ) ) as TISSQTY,
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  cast(sum( case when A.TotalGoodsMvtAmtInCCCrcy > 0 and A.DebitCreditCode = 'S'  
  then A.QuantityInBaseUnit else  A.QuantityInBaseUnit  * -1  end ) as abap.quan( 13, 3 ) )  as TOTQTY,
   
   
   
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat )  between 0   and $parameters.RQTY  and A.DebitCreditCode = 'S'  and A.GoodsMovementType <> '303'
  and cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 ) > 0 then  cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 )
  else 0 end ) as abap.curr( 13, 2 ) )  as  amt    ,
 
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 cast( sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY  and dats_days_between( B.POSTINGDATE, $parameters.p_budat ) <= $parameters.RQTY1 
  and  A.DebitCreditCode = 'S'  and A.GoodsMovementType <> '303' and cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 ) > 0
  then cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 ) 
  else 0 end ) as abap.curr( 13, 2 ) )  as amt1 ,
  
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY1 and dats_days_between( B.POSTINGDATE, $parameters.p_budat ) <= $parameters.RQTY2 
  and  A.DebitCreditCode = 'S'  and A.GoodsMovementType <> '303' 
  and cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 ) > 0 then cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 )
  else 0 end ) as abap.curr( 13, 2 ) )  as amt2 ,
  
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast( sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY2 and dats_days_between( B.POSTINGDATE, $parameters.p_budat ) <= $parameters.RQTY3 
  and  A.DebitCreditCode = 'S' and A.GoodsMovementType <> '303'  and cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 ) > 0 
  then cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 )  
  else  0 end ) as abap.curr( 13, 2 ) ) as amt3 ,


@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY3 and dats_days_between( B.POSTINGDATE, $parameters.p_budat ) <= $parameters.RQTY4 
   and  A.DebitCreditCode = 'S'  and A.GoodsMovementType <> '303' and cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 ) > 0 
   then cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 )
      else 0 end ) as abap.curr( 13, 2 ) ) as amt4 ,
  
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum( case when dats_days_between( B.POSTINGDATE, $parameters.p_budat ) > $parameters.RQTY4 and A.DebitCreditCode = 'S'  and A.GoodsMovementType <> '303' 
  and cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 ) > 0 then cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 )  
  else 0 end ) as abap.curr( 13, 2 ) ) as amt5,
  
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
 cast(sum( case when A.DebitCreditCode = 'H' then cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 )  else 0 end   ) as abap.curr( 13, 2 ) ) as TISSamt, 
   
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
  cast(sum( case when cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 ) > 0 and A.DebitCreditCode = 'S'  
  then cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 ) else  cast(A.TotalGoodsMvtAmtInCCCrcy as abap.int8 )  * -1  end ) as abap.curr( 13, 2 ) )  as TOTAMT
   
   
   
   
   
   
   
   
   

} where A.QuantityInBaseUnit > 0
   group by A.Plant, A.Material ,A.StorageLocation ,
   A.MaterialBaseUnit,A.Batch,A.CompanyCodeCurrency
   
