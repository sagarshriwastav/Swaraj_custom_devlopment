@AbapCatalog.sqlViewName: 'Y501STOCK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Stock Report 501 As On Date'
define view YPP_STOCK_CDS_501_2 
with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats
    as select from YPP_STOCK_CDS_501 as master
     left outer join YPP_STOCK_CDS_OPEN_N( P_KeyDate: $parameters.p_fromdate )                   
                                                                      as open  on  open.Material        = master.Material
                                                                      and open.Plant           = master.Plant
                                                                      and open.StorageLocation = master.StorageLocation
                                                                       and open.Batch           = master.Batch
     left outer join YPP_STOCK_CDS_ISSUE2_N501( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) 
                                                                   as mid   on  mid.Material        = master.Material
                                                                   and mid.Plant           = master.Plant
                                                                   and mid.StorageLocation = master.StorageLocation
                                                                   and mid.Batch           = master.Batch
     
     left outer join YPP_STOCK_CDS_OPEN_N(  P_KeyDate: $parameters.p_todate ) 
                                                                   as close on  close.Material        = master.Material
                                                                   and close.Plant           = master.Plant
                                                                   and close.StorageLocation = master.StorageLocation
                                                                   and close.Batch           = master.Batch
{
    
  master.Material,
  master.Plant,
  master.StorageLocation,  
  master.Batch ,
  master.MaterialDocument,
  master.Customer,
  master.GoodsMovementType,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  open.MatlWrhsStkQtyInMatlBaseUnit  as Opening,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  mid.Receipt                        as Receipt,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  mid.RevReceipt                     as RevReceipt,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 close.MatlWrhsStkQtyInMatlBaseUnit  as Closing,
  master.MaterialBaseUnit
  
}
where 
  (
       master.GoodsMovementType = '501' or master.GoodsMovementType = '502'  and master.Plant  = '1300' )
 and ( master.PostingDate        <= $parameters.p_todate    )
//  and  master.Material          like 'Y%'
//  and  master.Batch != ''
group by
  master.Material,
  master.Plant,
  master.StorageLocation,
  master.Batch ,
  master.GoodsMovementType,
  master.MaterialDocument,
  master.Customer,
  master.MaterialBaseUnit,
  open.MatlWrhsStkQtyInMatlBaseUnit,
  mid.Receipt,
  mid.RevReceipt,
  close.MatlWrhsStkQtyInMatlBaseUnit
