@AbapCatalog.sqlViewName: 'YPRINTQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Facory Beam Print'
define view YARN_FACTORY_QTY_CDS  with parameters 
                p_plant : abap.char( 4 ) ,
                p_cust  : abap.char( 10 ) ,
            @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
    as select from  I_MaterialDocumentItem_2 as a 
{
    key a.Customer,
    key a.Material,
    key a.MaterialDocument,
        a.MaterialBaseUnit,
        
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
 sum( case when a.DebitCreditCode = 'S' 
       and ( a.GoodsMovementType = '501' ) and Material not like 'BDJ%' and Material not like 'BDJL%'
       then  a.QuantityInBaseUnit  
     //   when a.DebitCreditCode = 'S' 
     //  and ( a.GoodsMovementType = '501' ) and Material like 'BDJ%'
    //   then  cast( cast( a.GoodsRecipientName as abap.numc( 12 )) as abap.quan( 13, 3 )) 
    end )  as Reciept_Qty,      
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit' 
 sum( case when a.DebitCreditCode = 'S' 
       and ( a.GoodsMovementType = '501' ) and Material like 'BDJ%'
       then  cast( cast( a.GoodsRecipientName as abap.numc( 12 )) as abap.quan( 13, 3 )) end ) as Reciept_QtyBDJ,   
       
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'    
 sum( case  when  a.DebitCreditCode = 'H'
       and ( a.GoodsMovementType = '502' ) and Material not like 'BDJ%' and Material not like 'BDJL%'
       then  a.QuantityInBaseUnit
     //  when  a.DebitCreditCode = 'H' and ( a.GoodsMovementType = '502' )  and Material like 'BDJ%'
     //  then  cast( cast( a.GoodsRecipientName as abap.numc( 12 )) as abap.quan( 13, 3 )) 
     end ) as Return_Qty, 
       
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'    
 sum( case  when  a.DebitCreditCode = 'H'
       and ( a.GoodsMovementType = '502' )  and Material like 'BDJ%' 
       then   cast( cast( a.GoodsRecipientName as abap.numc( 12 )) as abap.quan( 13, 3 )) end ) as Return_QtyBDJ, 
       
       @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
  sum( case when a.DebitCreditCode = 'H' 
       and ( a.GoodsMovementType = '601' ) and Material not like 'BDJ%' and Material not like 'BDJL%' and Material not like 'Y%' and Material not like 'FFT%'
       then  a.QuantityInBaseUnit   
       
      // when a.DebitCreditCode = 'H' 
      // and ( a.GoodsMovementType = '601' ) and Material like 'BDJ%' and Material not like 'Y%' and Material not like 'FFT%'
     //  then   cast( cast( a.GoodsRecipientName as abap.numc( 12 )) as abap.quan( 13, 3 ))
       
       when  a.DebitCreditCode = 'S'
       and ( a.GoodsMovementType = '602' ) and Material not like 'BDJ%' and Material not like 'BDJL%' and Material not like 'Y%' and Material not like 'FFT%'
       then -1 * a.QuantityInBaseUnit
       
   //    when a.DebitCreditCode = 'S'
   //    and  ( a.GoodsMovementType = '602' ) and Material like 'BDJ%'    and Material not like 'Y%' and Material not like 'FFT%'
   //    then -1 * ( cast( cast( a.GoodsRecipientName as abap.numc( 12 )) as abap.quan( 13, 3 )) )
       
       end ) as Dispatc_QTY,
       
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
  sum( case when a.DebitCreditCode = 'H' 
       and ( a.GoodsMovementType = '601' ) and Material like 'BDJ%' and Material not like 'BDJL%' and Material not like 'Y%' and Material not like 'FFT%'
       then   cast( cast( a.GoodsRecipientName as abap.numc( 12 )) as abap.quan( 13, 3 ))
       when  a.DebitCreditCode = 'S'
       and  ( a.GoodsMovementType = '602' ) and Material like 'BDJ%' and Material not like 'BDJL%'  and Material not like 'Y%' and Material not like 'FFT%'
       then -1 *  ( cast( cast( a.GoodsRecipientName as abap.numc( 12 )) as abap.quan( 13, 3 )) )
       end ) as Dispatc_QTYBDJ
}   

   where a.PostingDate between $parameters.p_posting  and $parameters.p_posting1
  and a.Plant = $parameters.p_plant and a.Customer = concat( '000',$parameters.p_cust ) 
  and a.GoodsMovementIsCancelled = '' and a.ReversedMaterialDocument = ''
   group by a.Customer,
           a.Material,
           a.MaterialDocument,
           a.MaterialBaseUnit
  
