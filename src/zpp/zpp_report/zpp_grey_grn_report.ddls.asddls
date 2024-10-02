@AbapCatalog.sqlViewName: 'YGREYREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Grn Report'
define view ZPP_GREY_GRN_REPORT as select from zpp_grey_grn_tab as  a  
              left outer join I_MaterialDocumentItem_2 as e on ( e.MaterialDocument = a.materialdocument101  
                                                        and e.MaterialDocumentYear = a.materialdocumentyear101 
                                                        and e.Material = a.material
                                                        and e.Batch = a.recbatch 
                                                        and ( e.GoodsMovementType = '101' or e.GoodsMovementType = '561' )  )                                                
 //             inner join ymseg4 as g on ( g.MaterialDocument = e.MaterialDocument 
 //                                    and g.MaterialDocumentItem = e.MaterialDocumentItem 
 //                                    and g.MaterialDocumentYear = e.MaterialDocumentYear )
                                                                                    
                left outer join Ymat_STOCK1_SUM2 as b on ( b.Material = a.material and b.Batch = a.recbatch
                                           and b.Plant = a.plant ) 
               left outer join I_DeliveryDocumentItem as c on  ( c.Material = a.material 
                                                       and c.Batch = a.recbatch ) 
               left outer join I_ProductDescription    as d on ( d.Product = a.material and d.Language = 'E' )                                     
{
    key a.plant as Plant,
    key a.batch as Batch,
    key a.recbatch as Recbatch,
    key a.materialdocument101 as Materialdocument101,
    a.materialdocumentyear101 as Materialdocumentyear101,
 //   e.MaterialDocumentItem,
    a.postingdate as Postingdate,
    a.optcode as Optcode,
    a.shift as Shift,
    a.srno as Srno,
    cast( count( distinct a.batch ) as abap.dec( 13, 0 ) ) as  zCount ,
    a.loomno as Loomno,
    a.material as Material,
    d.ProductDescription as Materialdec,
    a.rollno as Rollno,
    a.partybeam as Partybeam,
    a.pick as Pick,
    a.partyname as Partyname,
    a.quantity as Quantity,
    a.netwt as Netwt,
    a.wtmtr as Wtmtr,
    a.stdwt as Stdwt,
    a.prodorder as Prodorder,
    a.sloc as Sloc,
    a.shadeno as Shadeno,
    a.remark as Remark,
    a.uom as Uom,
    a.ukg as Ukg,
    a.salesord as Salesord,
    a.salesorderitem as Salesorderitem,
    a.materialdocument261 as Materialdocument261,
    a.materialdocumentyear261 as Materialdocumentyear261,
    case when b.STock is not null or b.STock is not initial  then 'X'
    else '' end as Stock,
    case when c.PackingStatus = 'C'  then 'X'
    else '' end as Delivery,
    a.grosswt,
    a.setno,
    a.selvedge,
    e.GoodsMovementIsCancelled
 //   e.GoodsMovementIsCancelled ,
 //   e.ReversedMaterialDocument
 } //where ( e.GoodsMovementIsCancelled = '' or e.GoodsMovementIsCancelled is null or e.GoodsMovementIsCancelled is initial )
   //  and ( e.ReversedMaterialDocument = '' or e.ReversedMaterialDocument is null or e.ReversedMaterialDocument is initial )
 
 where ( e.GoodsMovementIsCancelled != 'X'   or   e.GoodsMovementType = '561'   ) 

 
  group by 
  a.plant,
  a.batch,
  a.recbatch,
  a.materialdocument101 ,
  a.materialdocumentyear101 ,
//  e.MaterialDocumentItem,
 // e.GoodsMovementIsCancelled ,
 // e.ReversedMaterialDocument,
  a.postingdate ,
  a.optcode,
  a.shift,
  a.srno ,
  a.loomno ,
    a.material,
    d.ProductDescription,
    a.rollno ,
    a.partybeam ,
    a.pick ,
    a.partyname,
    a.quantity ,
    a.netwt ,
    a.wtmtr ,
    a.stdwt ,
    a.grosswt,
    a.prodorder ,
    a.sloc,
    a.shadeno,
    a.remark ,
    a.uom ,
    a.ukg ,
    a.salesord,
    a.salesorderitem ,
    a.materialdocument261 ,
    a.materialdocumentyear261,
    b.STock,
    c.PackingStatus,
    a.setno,
    a.selvedge,
    e.GoodsMovementIsCancelled
  
  
  
  
