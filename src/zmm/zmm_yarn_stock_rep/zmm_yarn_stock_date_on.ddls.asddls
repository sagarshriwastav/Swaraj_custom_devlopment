@AbapCatalog.sqlViewName: 'YSTKREPORTCDSN '
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Stock Report Date on'
define view ZMM_YARN_STOCK_DATE_ON 
    with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats                         
    as select from   ypp_material_master_lot                 as master    

    
    left outer join YPP_STOCK_CDS_OPEN_N( P_KeyDate: $parameters.p_fromdate )                   
                                                                      as open  on  open.Material        = master.Material
                                                                      and open.Plant           = master.Plant
                                                                      and open.StorageLocation = master.StorageLocation
                                                                       and open.Batch           = master.Batch
    left outer join YPP_STOCK_CDS_ISSUE2_N( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) 
                                                                   as mid   on  mid.Material        = master.Material
                                                                   and mid.Plant           = master.Plant
                                                                   and mid.StorageLocation = master.StorageLocation
                                                                   and mid.Batch           = master.Batch
     
    left outer join YPP_STOCK_CDS_OPEN_N( P_KeyDate: $parameters.p_todate )                             
                                                                   as close on  close.Material        = master.Material
                                                                   and close.Plant           = master.Plant
                                                                   and close.StorageLocation = master.StorageLocation
                                                                   and close.Batch           = master.Batch
{
  master.Material,
  master.Plant,
  master.StorageLocation,  
  master.Batch ,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  open.MatlWrhsStkQtyInMatlBaseUnit  as Opening,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  mid.Receipt                        as Receipt,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  mid.RevReceipt                     as RevReceipt,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  mid.Issue                          as Issue,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  mid.RevIssue                       as RevIssue,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 close.MatlWrhsStkQtyInMatlBaseUnit  as Closing,
  master.MaterialBaseUnit
  
}
where
  (
       master.GoodsMovementType = '101' or GoodsMovementType = '261'
    or master.GoodsMovementType = '561' // or master.GoodsMovementType = '309'  or master.GoodsMovementType = '653'
    or master.GoodsMovementType = '311'
    or master.GoodsMovementType = '301'
  )
 and ( master.PostingDate        <= $parameters.p_todate    )
//  and  master.Material          like 'Y%'
//  and  master.Batch != ''
group by
  master.Material,
  master.Plant,
  master.StorageLocation,
  master.Batch ,
  master.MaterialBaseUnit,
  open.MatlWrhsStkQtyInMatlBaseUnit,
  mid.Receipt,
  mid.RevReceipt,
  mid.Issue,
  mid.RevIssue,
  close.MatlWrhsStkQtyInMatlBaseUnit
