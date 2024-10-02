@AbapCatalog.sqlViewName: 'YSMPL2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_SAMPLING_REPORT'
define view ZPP_SAMPLING_REPORT2 
    with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats                         
    as select from   ZPP_SAMPLING_REPORT as master  
    left outer join ZPP_SAMPLING_REP_OPENING1( P_KeyDate: $parameters.p_fromdate ) as open  on 
                                                                          open.Material        = master.Material
                                                                      and open.Plant           = master.Plant
                                                                      and open.StorageLocation = master.StorageLocation
                                                                       and open.Batch           = master.Batch
                                                                        
    left outer join ZPP_SAMPLING_REP_RECEIPT1( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) as RECIPT1 on  
                                                                       RECIPT1.Material        = master.Material
                                                                   and RECIPT1.Plant           = master.Plant
                                                             //      and RECIPT1.StorageLocation = master.StorageLocation
                                                                   and RECIPT1.Batch           = master.Batch
    left outer join ZPP_SAMPLING_ISSUE1( p_fromdate : $parameters.p_fromdate , p_todate : $parameters.p_todate ) as ISSUE on  
                                                                       ISSUE.Material        = master.Material
                                                                   and ISSUE.Plant           = master.Plant
                                                                   and ISSUE.StorageLocation = master.StorageLocation
                                                                   and ISSUE.Batch           = master.Batch                                                               
    left outer join YPP_STOCK_CDS_OPEN_N( P_KeyDate: $parameters.p_todate ) as close on  
                                                                       close.Material        = master.Material
                                                                   and close.Plant           = master.Plant
                                                                   and close.StorageLocation = master.StorageLocation
                                                                   and close.Batch           = master.Batch
{
 key master.Material,
 key master.Plant,
 key master.StorageLocation,  
 key master.Batch ,
  master.MaterialBaseUnit,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  open.MatlWrhsStkQtyInMatlBaseUnit  as Opening,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  RECIPT1.Receipt                    as Receipt,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  ISSUE.Issue                      as Issue,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  close.MatlWrhsStkQtyInMatlBaseUnit  as Closing
 
  
  
}
where
 ( master.PostingDate        <= $parameters.p_todate    )
group by
  master.Material,
  master.Plant,
  master.StorageLocation,
  master.Batch ,
  master.MaterialBaseUnit,
  open.MatlWrhsStkQtyInMatlBaseUnit,
  RECIPT1.Receipt,
  ISSUE.Issue,
  close.MatlWrhsStkQtyInMatlBaseUnit
  
