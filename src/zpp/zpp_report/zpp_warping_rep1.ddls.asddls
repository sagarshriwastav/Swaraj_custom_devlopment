@AbapCatalog.sqlViewName: 'YPPWARPING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Warping Entry Report'
define view ZPP_WARPING_REP1 as select from zwarping_entry as a 
  //left outer join I_MaterialDocumentItem_2 as b on (b.Batch = a.zfset_no and b.Plant =  '1200' 
  //                                                 and b.StorageLocation = 'WRP1' and b.GoodsMovementType = '101'
    //                                               and b.GoodsMovementIsCancelled = '' and b.Material like 'BW%')
       left outer join I_ManufacturingOrder as F on ( F.Batch = a.zfset_no  )
    

{
    key a.zfset_no as ZfsetNo,
    key a.zmc_no as ZmcNo,
    key a.beamno as Beamno,
    a.zlength as Zlength,
    a.material as Material,
    a.avgbpmm as avgbpmm ,
    a.beamin1creel as beamin1creel ,
    a.supplierconweight as supplierconweight ,
    a.ends as Ends,
    a.totends as Totends,
    a.beamlenght as Beamlenght,
    @Semantics.quantity.unitOfMeasure: 'zunit'
    a.grooswt as Grooswt,
    @Semantics.quantity.unitOfMeasure: 'zunit'
    a.tarewt as Tarewt,
    @Semantics.quantity.unitOfMeasure: 'zunit'
    a.netwt as Netwt,
    a.rpm as Rpm,
    a.warper as Warper,
    a.zcount as Zcount,
    a.breaks as Breaks,
    a.breaksmtr as Breaksmtr,
    cast( case when a.zunit = '' then
    'KG' else a.zunit end as abap.unit( 3 ) ) as zunit,
    F.ManufacturingOrder,
    
    cast( 'M' as abap.unit( 3 ) ) as MUNIT,
    a.zdate as PostingDate

}  where F.ManufacturingOrderType = 'SWP1'
