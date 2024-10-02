@AbapCatalog.sqlViewName: 'YARNBEAM2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Facory Beam Report'
define view YARN_FACTORY_BEAM_L_1 
with parameters 
                p_plant : abap.char( 4 ) ,
                p_cust  : abap.char( 10 ) ,
            @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
as select from I_MaterialDocumentItem_2 as a 

left outer join Yarn_Factory_Beam_OPEN_N( P_KeyDate: $parameters.p_posting ) as b on (a.Material = b.Material 
                                                  and a.Plant = b.Plant
                                                  and a.Customer = b.Customer
                                                   ) 
  left outer join YARN_FACTORY_QTY( p_plant:$parameters.p_plant , p_cust:$parameters.p_cust,
                                    p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 )
                                    as Mid on (Mid.Customer = a.Customer and Mid.Material = a.Material 
                                               and Mid.MaterialDocument = a.MaterialDocument ) 
                                                                                               
 left outer join Yarn_Factory_Beam_Desp_WT( p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 ) 
                                           as d on ( d.MaterialDocument = a.MaterialDocument 
                                           and d.MaterialDocumentYear = a.MaterialDocumentYear 
                                           and d.Material = a.Material )                               
left outer join I_MaterialDocumentHeader_2 as c on (c.MaterialDocument = a.MaterialDocument 
                                                    and c.MaterialDocumentYear = a.MaterialDocumentYear )  
  left outer join I_Customer as e on ( e.Customer = a.Customer ) 
  left outer join I_ProductDescription as f on ( f.Product = a.Material and f.Language = 'E')   
  left outer join Yarn_Factory_Beam_CLOSE_N( P_KeyDate: $parameters.p_posting1 ) as Closing on (Closing.Material = a.Material 
                                                  and Closing.Plant = a.Plant
                                                  and Closing.Customer = a.Customer
                                                   )                                                            
                                                   
{
 key a.Customer,
 key a.PostingDate as PostingDate,
 key case when a.DeliveryDocument =  ''
     then c.ReferenceDocument
     else
   a.DeliveryDocument end as Challan_no,
 key a.Material,
 key a.MaterialDocument,
   a.MaterialBaseUnit,
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 sum( b.MatlWrhsStkQtyInMatlBaseUnit ) as Opening_Stk,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 sum( Closing.MatlWrhsStkQtyInMatlBaseUnit ) as Closing_Stk,
 d.Netwt,
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 Mid.Reciept_Qty,
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'    
 Mid.Return_Qty, 
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
 Mid.Dispatc_QTY,
       e.CustomerName,
       f.ProductDescription
       
    
}  
where //a.PostingDate between $parameters.p_posting  and $parameters.p_posting1
     a.PostingDate <= $parameters.p_posting1 and
     a.Plant = $parameters.p_plant and a.Customer = concat( '000',$parameters.p_cust ) 
  and a.GoodsMovementIsCancelled = '' and a.ReversedMaterialDocument = ''
group by  
       a.Customer,
       a.PostingDate,
       a.DeliveryDocument,
       a.Material,
       a.MaterialDocument,
       c.ReferenceDocument,
       a.MaterialBaseUnit,
       Mid.Reciept_Qty,
       Mid.Return_Qty, 
       Mid.Dispatc_QTY,
       d.Netwt,
       e.CustomerName,
       f.ProductDescription

  
