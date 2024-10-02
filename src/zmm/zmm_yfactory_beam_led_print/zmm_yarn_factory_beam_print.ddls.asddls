@AbapCatalog.sqlViewName: 'ZMMYARN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Facory Beam Print'
define view ZMM_YARN_FACTORY_BEAM_PRINT with parameters 
                p_plant : abap.char( 4 ) ,
                p_cust  : abap.char( 10 ) ,
            @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
  as select from I_MaterialDocumentItem_2 as a 
   left outer join YARN_FACTORY_QTY_CDS( p_plant:$parameters.p_plant , p_cust:$parameters.p_cust,
                                    p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 )
                                    as Mid on (Mid.Customer = a.Customer and Mid.Material = a.Material 
                                               and Mid.MaterialDocument = a.MaterialDocument ) 
                                                                                               
   left outer join Yarn_Factory_Beam_Desp_WT_CDS( p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 ) 
                                           as d on ( d.MaterialDocument = a.MaterialDocument 
                                           and d.MaterialDocumentYear = a.MaterialDocumentYear 
                                           and d.Material = a.Material )                               
   left outer join I_MaterialDocumentHeader_2 as c on (c.MaterialDocument = a.MaterialDocument 
                                                    and c.MaterialDocumentYear = a.MaterialDocumentYear )  
   left outer join I_Customer as e on ( e.Customer = a.Customer ) 
   left outer join I_ProductDescription as f on ( f.Product = a.Material and f.Language = 'E')                                                           
                                                   
{
 key a.Customer,
 key a.PostingDate as PostingDate,
 key a.Plant,
 key case when a.DeliveryDocument =  ''
     then c.ReferenceDocument
     else
   a.DeliveryDocument end as Challan_no,
 key a.Material,
 key a.MaterialDocument,
   a.MaterialBaseUnit,
 d.Netwt as Netwt,
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 Mid.Reciept_Qty as Reciept_Qty,
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 Mid.Reciept_QtyBDJ as Reciept_QtyBDJ,
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'    
 Mid.Return_Qty as Return_Qty, 
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'    
 Mid.Return_QtyBDJ as Return_QtyBDJ, 
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
 Mid.Dispatc_QTY as Dispatc_QTY,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
 Mid.Dispatc_QTYBDJ as Dispatc_QTYBDJ,
       e.CustomerName,
       e.CityName,
       e.AddressID,
       f.ProductDescription
    //   a.Batch
       
    
}  
where a.PostingDate between $parameters.p_posting  and $parameters.p_posting1
    and a.Plant = $parameters.p_plant and a.Customer = concat( '000',$parameters.p_cust ) 
     and a.GoodsMovementIsCancelled = '' and a.ReversedMaterialDocument = ''
group by  
       a.Customer,
       a.PostingDate,
       a.Plant,
       a.DeliveryDocument,
       a.Material,
       a.MaterialDocument,
       c.ReferenceDocument,
       a.MaterialBaseUnit,
       Mid.Reciept_Qty,
       Mid.Return_Qty, 
       Mid.Dispatc_QTY,
       Mid.Reciept_QtyBDJ,
       Mid.Return_QtyBDJ, 
       Mid.Dispatc_QTYBDJ,
       d.Netwt,
       e.CustomerName,
       e.CityName,
       e.AddressID,
      f.ProductDescription
//       a.Batch
