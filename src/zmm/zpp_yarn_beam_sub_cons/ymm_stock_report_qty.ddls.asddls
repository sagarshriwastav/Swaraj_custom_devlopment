@AbapCatalog.sqlViewName: 'YMM_STORE_QTY'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MM Stock Report Quantity'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view YMM_STOCK_REPORT_QTY
  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
  as select from    I_MaterialDocumentItem_2                 as master 
   inner join ymseg4 as CNCL on ( CNCL.MaterialDocument = master.MaterialDocument 
                                 and CNCL.MaterialDocumentItem = master.MaterialDocumentItem
                                 and CNCL.MaterialDocumentYear = master.MaterialDocumentYear  )
   inner join  I_GoodsMovementCube as CODE on ( CODE.Batch = master.Batch 
                                                and CODE.Material = master.Material
                                                and CODE.MaterialDocument = master.MaterialDocument 
                                                and CODE.MaterialDocumentItem = master.MaterialDocumentItem
                                                and CODE.MaterialDocumentYear = master.MaterialDocumentYear
                                                                                                         )
   left outer join YMM_STORE_REPORT_OPEN( P_KeyDate: $parameters.p_fromdate )      as open  on  open.Material        = master.Material
                                                                                                     and open.Plant           = master.Plant 
                                                                                                     and open.Batch           = master.Batch
                                                                                                     and open.Supplier    = master.Supplier                    
    left outer join YMM_STORE_REPORT_ISSUE2( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) as mid   on
                                                                                mid.Material   = master.Material
                                                                                 and mid.Plant        = master.Plant 
                                                                                 and mid.Batch       = master.Batch 
                                                                                 and mid.Supplier    = master.Supplier
                                                                                                                         
    left outer join YMM_STORE_REPORT_OPEN( P_KeyDate: $parameters.p_todate )    as close on  close.Material        = master.Material
                                                                               and close.Plant           = master.Plant
                                                                               and close.Batch       = master.Batch 
                                                                               and close.Supplier   = master.Supplier
{
  master.Material,
  master.Plant,
  master.Supplier,  
  master.Batch,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  open.MatlWrhsStkQtyInMatlBaseUnit     as Opening,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  mid.Issue                           as Issue,
  @Semantics.amount.currencyCode: 'MaterialBaseUnit'
  mid.Consumption                     as Consumption,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  mid.RestunQty                       as RestunQty,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  close.MatlWrhsStkQtyInMatlBaseUnit    as Closing,
  master.MaterialBaseUnit,
  master.CompanyCodeCurrency
}
where
  (
      ( master.GoodsMovementType = '541' and CODE.GoodsMovementReasonCode = '0000' ) 
    or ( master.GoodsMovementType = '542' and CODE.GoodsMovementReasonCode = '0002'  )
    or master.GoodsMovementType = '543' ) and
//    or master.GoodsMovementType = '311'
//    or master.GoodsMovementType = '301'
//  ) and 
  ( master.InventorySpecialStockType = 'O' or master.InventorySpecialStockType = 'F' )
  and  master.PostingDate       <= $parameters.p_todate
group by
  master.Material,
  master.Plant,
  master.Batch,
  master.MaterialBaseUnit,
  master.CompanyCodeCurrency,
  open.MatlWrhsStkQtyInMatlBaseUnit,
  master.Supplier,
  mid.Issue,
  mid.Consumption,
  mid.RestunQty,
  close.MatlWrhsStkQtyInMatlBaseUnit
