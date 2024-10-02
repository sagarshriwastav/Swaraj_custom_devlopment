@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Shade'
define root view entity ZPP_SHADE_GRP_CDS as select from ZPACK_HDR_DEF as a 
  inner join I_ProductDescription as b on (a.MaterialNumber = b.Product and b.Language = 'E') 
  inner join ZPP_DNM_STOCK_SHADE as d on ( d.Batch = a.RecBatch and d.Material = a.MaterialNumber 
                                         and d.Plant = a.Plant )
  left outer join I_SalesDocumentItem as f on ( f.SalesDocument = d.SDDocument and f.SalesDocumentItem = d.SDDocumentItem )    
  left outer join I_Customer    as h on ( h.Customer = f.SoldToParty )                               
  left outer join ZPP_DNMSHADE_CDS as c on ( c.Material = a.MaterialNumber and c.Plant = a.Plant 
                                                and c.Follono = a.FolioNumber and c.Rollno = a.RecBatch )
   left outer join zpp_sortmaster as e on (  e.material = a.MaterialNumber and e.plant = a.Plant ) 
   left outer join zpp_finishing_CDS as g on ( g.finishrollno = a.Batch and g.material101 = a.MaterialNumber )
   left outer join I_ManufacturingOrderItem as l on ( l.ManufacturingOrder = g.orderno )
   left outer join zpc_headermaster   as j on ( j.zpqlycode = a.MaterialNumber )
                                                
{
    key a.Plant,
    key a.MaterialNumber as ProductionSort,
    key a.RecBatch as RollNumber,
    key a.FolioNumber,
        e.blend,
        f.MaterialByCustomer as PartySort,
        a.PostingDate as FolioDate,
        a.PackGrade,
        g.peice as peicenumbeer,
        a.Trollyno,
        a.Setno,
        a.RollLength,
        a.Tpremk,
        e.stdwidthinch,
        a.FinishWidth as actwidth,
        e.stdweight,
        e.dyeingshade,
        a.Point4,
        a.Totalpoint,
        e.tareweight,
        e.sort,
        a.NetWeight as gplm,
        d.StorageLocation,
        case when a.NoOfTp = '1' or a.NoOfTp = ' ' or a.NoOfTp = '0' then 
        'NO' else 'YES' end as MergedRoll,
        f.CreationDate,
        h.CustomerName,
        a.Party as Partyname,
        @Semantics.quantity.unitOfMeasure : 'UnitField'
        a.FinishWidth,
        a.UnitField,
        @Semantics.quantity.unitOfMeasure : 'UnitField'
        a.GrossWeight,
        a.RecevingLocation,
        b.ProductDescription,
        c.Shgrp,
        c.unshade,
    c.devationtype,
    c.dmreason,
    e.dyeingsort,
    e.finwd,
    e.weight,
    d.SDDocument,
    d.SDDocumentItem,
    e.shrinkage,
    e.pdno,
    j.ploom as loomtype,
    j.zpweavetype,
    a.OperatorName as rollpackingopt,
    g.optname  as finishingopt, 
    c.creationdate as creationdate1 ,
    c.creationtime as  creationtime1 ,
    case when l.ManufacturingOrderType = 'FDY1'  then 'Finish' 
   when l.ManufacturingOrderType = 'FPH1' then 'Finish' 
   when  l.ManufacturingOrderType = 'SFF1'  then 'Finish'
   when  l.ManufacturingOrderType = 'RT01' then 'Re-Finish' else ' ' end as FinishReFinish
}
   where f.CreationDate is not initial and a.PostingDate is not initial
        and  d.StorageLocation =  'FG01' 
   
