@AbapCatalog.sqlViewName: 'ZPP_GREYTABREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Job Grey Dispatch Stock Report'
define view ZSD_JOB_GREY_DISPATCH_STOCK_CD as select from Ymat_STOCK1_SUM2_job as b
                left outer join zpp_grey_grn_tab as a on ( b.Material = a.material and b.Batch = a.recbatch
                                           and b.Plant = a.plant )
                left outer join I_MaterialDocumentItem_2 as e on ( e.MaterialDocument = a.materialdocument101  
                                                        and e.MaterialDocumentYear = a.materialdocumentyear101 
                                                        and e.Material = a.material
                                                        and e.Batch = a.recbatch 
                                                        and e.GoodsMovementType = '101' )                            
               left outer join I_DeliveryDocumentItem as c on  ( c.Material = a.material 
                                                       and c.Batch = a.recbatch ) 
               left outer join I_ProductDescription    as d on ( d.Product = a.material and d.Language = 'E' )                                     
{
    key b.Plant as Plant,
    key b.Batch as BatchSending,   
    key b.Batch,      
    key a.materialdocument101,  
    b.Material as Material,
    a.postingdate as Postingdate,
    a.loomno as Loomno,
    d.ProductDescription as Materialdec,
    a.rollno as Rollno,
    a.partybeam as Partybeam,
    a.remark,
    cast( count( distinct a.batch ) as abap.dec( 13, 0 ) ) as  zCount ,
    b.MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    b.STock as StockQuantity,
    a.netwt as Netwt,
    a.wtmtr as Wtmtr,
    b.StorageLocation as Sloc,
    a.salesord as Salesord,
    a.salesorderitem as Salesorderitem,
    a.setno,
    a.selvedge,
    case when b.STock is not null or b.STock is not initial  then 'X'
    else '' end as Stock,
    a.uom as Uom,
    a.ukg as Ukg,
    a.partyname as Partyname,
    a.pick
    
 }    where b.STock > 0 and ( GoodsMovementIsCancelled = ' '  or GoodsMovementIsCancelled is null )
 group by   
 
   b.Plant ,
   b.Batch,
   b.Batch,      
   a.materialdocument101,  
   b.Material,
   a.postingdate,
   a.loomno,
   d.ProductDescription ,
   a.rollno,
   a.partybeam,
   a.netwt,
   a.wtmtr,
   b.StorageLocation,
   a.salesord,
   a.salesorderitem,
   a.setno,
   b.MaterialBaseUnit,
   b.STock,
   a.remark,
   a.selvedge,
   a.uom,
   a.ukg,
   a.partyname,
   a.pick
  
