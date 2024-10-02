@AbapCatalog.sqlViewName: 'YSTCOK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Finish Fabric Stock Report'
define view ZPP_FF_STOCK_CDS1 as select from ZPP_FF_STOCK as a  
            inner join I_ProductDescription as f on ( f.Product = a.Product and f.Language = 'E')
            left outer join zpackhdr as b on ( a.Batch =  right( b.rec_batch , 9 )   )       //  ( a.Batch  =  concat( '0', b.rec_batch ) )
             left outer join ZPP_FRC_REP as bB on ( a.Batch =  bB.Recbatch  ) 
            left outer join zpp_dnmshade as c on ( c.rollno = a.Batch )
            left outer join ZPP_FF_STOCK_CDS3 as d on ( d.Batch = a.Batch )
            left outer join zpp_sortmaster as e on (  e.material = a.Product and e.plant = a.Plant  )
            left outer join I_SalesDocumentItem as g on ( g.SalesDocument = a.SDDocument and g.SalesDocumentItem = a.SDDocumentItem )
            left outer join I_Customer as h on ( h.Customer = g.SoldToParty ) 
            left outer join zpp_finishing as I on ( I.material101 = a.Product and I.finishrollno = a.Batch )
            left outer join I_MaterialDocumentItem_2 as j on ( j.Material = a.Product and j.Batch = a.Batch 
                                                           and j.Plant = a.Plant  // and j.SalesOrder = a.SDDocument
                                                         //  and j.SalesOrderItem = a.SDDocumentItem 
                                                           and j.StorageLocation = a.StorageLocation 
                                                           and j.DebitCreditCode = 'S' ) 
                                                        
          
                                                           
{
   key a.Product,
   key a.Plant, 
   key a.StorageLocation,
   key a.Batch,
   a.MaterialBaseUnit,
   a.SDDocument,
   a.SDDocumentItem, 
    b.totalpoint,
   b.actozs,
   cast( 'KG' as abap.unit( 3 ) ) as ZUNIT,
   cast( ' ' as abap.unit( 3 ) ) as ZUNIT1,
   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//   a.CurrentStock,
   cast( a.CurrentStock as abap.dec( 13, 3) ) as CurrentStock ,
   cast( b.finish_width as abap.dec( 13, 0) ) as finish_width,
   b.folio_number,
    case when a.Product like 'WWFS001%'
            then
            bB.Gcgrosswt
         when a.Product like 'WWFS002%'
            then
            bB.Gcgrosswt  
         when a.Product like 'WWFS003%'
            then
            bB.Gcgrosswt 
         when a.Product like 'WWFS004%'
            then
            a.CurrentStock  
         when a.Product like 'WWFS005%'
            then
            a.CurrentStock 
        when a.Product like 'WWFS006%'
            then
            a.CurrentStock    
        when a.Product like 'WWFS007%'
            then
            a.CurrentStock             
            else
            b.gross_weight
            end                      as gross_weight,
//   b.gross_weight,
case when a.Product like 'WWFS001%'
            then
            bB.Gcgrosswt
          when a.Product like 'WWFS002%'
            then
            bB.Gcgrosswt  
           when a.Product like 'WWFS003%'
            then
            bB.Gcgrosswt 
          when a.Product like 'WWFS004%'
            then
            a.CurrentStock   
          when a.Product like 'WWFS005%'
            then
            a.CurrentStock 
        when a.Product like 'WWFS006%'
            then
            a.CurrentStock    
        when a.Product like 'WWFS007%'
            then
            a.CurrentStock           
            else
            b.net_weight
            end                      as net_weight,
//   b.net_weight,
   b.pack_grade,
   b.posting_date as PackingDate,
   c.shgrp,
   c.unshade,
   c.devationtype,
   c.dmreason,
   d.YY1_TrollyNumber_CFM,
   e.pdno,
   e.dyeingshade,
   e.dyeingsort as Dyeingsort,
   e.finwd as Finwd,
   e.weight as Weight,
   f.ProductDescription,
   g.SoldToParty,
   g.MaterialByCustomer,
   h.CustomerName, 
  
//   B.totalpoint * 36 * 100 / A.CurrentStock / B.finish_width AS DPT_YDS,
//  cast( B.totalpoint as ABAP.DEC( 13, 3 ) ) * 36 * 100 / cast( A.CurrentStock as ABAP.DEC( 13, 3 ) ) * cast( B.finish_width as ABAP.DEC( 13, 3 ) ) AS DPT_YDS,
  ( cast( b.totalpoint as abap.fltp )   * cast( 3600 as abap.fltp ) ) / ( cast( a.CurrentStock as abap.fltp ) * cast( b.finish_width as abap.fltp ) ) as DPT_YDS1,
   
   count( distinct a.Batch ) as PcsNo,
   I.trollyno,
   max(j.PostingDate) as PostingDate
   
}
 where 
 a.CurrentStock > 0
// case when a.Product like 'WWFS%'
//            then
//            a.CurrentStock > '1'
//            else
//            a.CurrentStock > 0
            
    group by 
      a.Product,
      a.Plant,
      a.StorageLocation,
      a.Batch,
      a.MaterialBaseUnit,
      a.SDDocument,
      a.SDDocumentItem,
      a.CurrentStock,
      b.finish_width ,
      b.folio_number,
      b.gross_weight,
      b.net_weight,
      b.pack_grade,
      b.posting_date,
      c.shgrp,
      c.unshade,
      c.devationtype,
      c.dmreason,
      d.YY1_TrollyNumber_CFM,
      e.pdno,
      e.dyeingshade,
      e.dyeingsort,
      e.finwd,
      e.weight ,
      f.ProductDescription,
      g.SoldToParty,
      g.MaterialByCustomer,
      h.CustomerName,
      I.trollyno,
      bB.Gcgrosswt,
      bB.Totalwt,
      b.totalpoint,
      b.actozs
    
      
     
