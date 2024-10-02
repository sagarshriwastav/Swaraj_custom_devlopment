@AbapCatalog.sqlViewName: 'YDISPATCH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Consumption Report MM 1200 Plant'
define view ZMM_YARN_CONSURPT_1200_DSTPACH 
with parameters 
             @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats 
          as select from ZPACK_HEAD_REP_CDS as a 
left outer join I_MaterialDocumentItem_2 as b on ( b.Material = a.MaterialNumber and b.Batch = a.RecBatch and b.Plant = a.Plant 
                                                  and b.StorageLocation = a.RecevingLocation )
                                                  
{
    key a.MaterialNumber as Material,
    key a.Setno as Batch,
    key a.Plant,
        a.UnitField as MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
      sum( case when b.DebitCreditCode = 'H' 
       and ( b.GoodsMovementType = '601' )
       then  b.QuantityInBaseUnit  
       when  b.DebitCreditCode = 'S'
       and ( b.GoodsMovementType = '602' ) 
       then -1 * b.QuantityInBaseUnit  
       end ) as Dispatc_QTY
        
}  
  where ( b.GoodsMovementType = '601' or b.GoodsMovementType = '602' )
     and a.PostingDate > $parameters.p_posting  and a.PostingDate <= $parameters.p_posting1
     group by 
        a.MaterialNumber,
        a.Setno,
        a.UnitField,
        a.Plant
