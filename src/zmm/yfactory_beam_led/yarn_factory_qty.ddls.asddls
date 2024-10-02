@AbapCatalog.sqlViewName: 'YQTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Facory Beam Qty'
define view YARN_FACTORY_QTY 
  with parameters 
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
       and ( a.GoodsMovementType = '501' )
       then  a.QuantityInBaseUnit end ) as Reciept_Qty,
 @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'    
 sum( case  when  a.DebitCreditCode = 'H'
       and ( a.GoodsMovementType = '502' )
       then  a.QuantityInBaseUnit end ) as Return_Qty, 
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
  sum( case when a.DebitCreditCode = 'H' 
       and ( a.GoodsMovementType = '601' )
       then  a.QuantityInBaseUnit 
       when  a.DebitCreditCode = 'S'
       and ( a.GoodsMovementType = '602' )    
       then -1 * a.QuantityInBaseUnit
       end ) as Dispatc_QTY
}   

   where a.PostingDate between $parameters.p_posting  and $parameters.p_posting1
  and a.Plant = $parameters.p_plant and a.Customer = concat( '000',$parameters.p_cust ) 
  and a.GoodsMovementIsCancelled = '' and a.ReversedMaterialDocument = ''
   group by a.Customer,
           a.Material,
           a.MaterialDocument,
           a.MaterialBaseUnit
  
