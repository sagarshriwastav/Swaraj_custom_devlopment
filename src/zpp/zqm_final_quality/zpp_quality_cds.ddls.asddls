@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Quality Insp'
define root view entity ZPP_QUALITY_CDS as select from ZQAS_REP1 as a  
         inner join I_Product as j on ( j.Product = a.Material )
         left outer join zpp_sortmaster as e on ( ( e.material = a.Material and e.plant = a.Plant )
                                                       or (e.pdcode = a.Material and e.plant = a.Plant ) )
         left outer join zpp_sortmaster as f_GS on  ( f_GS.pdcode = right(a.Material,7) and f_GS.plant = a.Plant )                                             
         left outer join zpp_finishing_CDS as f on ( f.finishrollno = a.Batch and f.material101 = a.Material )
         left outer join I_ManufacturingOrderItem as g on ( g.ManufacturingOrder = f.orderno )
         left outer join I_SalesDocument  as h on ( h.SalesDocument = a.SDDocument )
         left outer join I_Customer as i on ( i.Customer = h.SoldToParty )
         left outer join I_MaterialDocumentHeader_2 as GSS on ( GSS.MaterialDocument = f.materialdocument101
                                                                and GSS.MaterialDocumentYear = f.materialdocumentyear101 )                                                        

{
   key a.Plant,
   key a.Material,
   key a.Batch,
   a.SDDocument,
   a.SDDocumentItem,
   a.StorageLocation,
   a.MaterialBaseUnit,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   a.StockQty,
   a.ProductDescription,
   case when e.dyeingshade = '' or e.dyeingshade is initial or e.dyeingshade is null
   then f_GS.dyeingshade else e.dyeingshade end as dyeingshade,
   case when  e.stretch = '' or e.stretch is null or e.stretch is initial 
   then f_GS.stretch else e.stretch end as stretch,
   case when e.dyeingsort = '' or e.dyeingsort is null or e.dyeingsort is initial
   then f_GS.dyeingsort else e.dyeingsort end as dyeingsort ,
   case when e.processroute = '' or e.processroute is null or e.processroute  is initial 
   then f_GS.processroute else e.processroute end as route,
   f.setno,
   f.loomnumber,
   f.trollyno,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   f.greigemtr,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
   f.finishmtr,
   f.partyname,
   f.optname,
//   f.route,
   f.orderno,
   f.greywidth, 
   case when g.ManufacturingOrderType = 'FDY1'  then 'Finish' 
   when g.ManufacturingOrderType = 'FPH1' then 'Finish' 
   when  g.ManufacturingOrderType = 'SFF1'  then 'Finish'
   when  g.ManufacturingOrderType = 'RT01' then 'Re-Finish' else ' ' end as FinishReFinish,
   i.CustomerName,
   GSS.CreationTime,
   GSS.PostingDate
}
  where a.StockQty > 0
      and ( j.ProductType like 'ZFFO%' or j.ProductType like 'ZGFO%' or j.ProductType like 'ZPDN%' )
