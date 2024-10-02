@AbapCatalog.sqlViewName: 'YARNCON3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Consumption Report'
define view ZMM_YARN_CONSUMPTION_CDS3 with parameters 
             @Environment.systemField: #SYSTEM_DATE    
                p_posting:abap.dats,
             @Environment.systemField: #SYSTEM_DATE
                p_posting1:abap.dats
as select from ZMM_YARN_CONSUMPTION_CDS2 (p_posting:$parameters.p_posting , p_posting1:$parameters.p_posting1 ) as a
  left outer join I_MaterialDocumentItem_2 as b on (b.Material = a.Material and b.Batch = a.Batch and b.Plant = a.Plant 
                                                   and b.GoodsMovementType = '261' and b.GoodsMovementIsCancelled = ''
                                                    ) 
  left outer join I_ManufacturingOrderItem   as c on ( c.ManufacturingOrder = b.OrderID ) 
  left outer join I_MaterialDocumentItem_2 as d on ( d.Material = c.Material and d.SalesOrder = c.SalesOrder 
                                                    and d.SalesOrderItem = c.SalesOrderItem and d.Plant = c.ProductionPlant
                                                   and ( d.GoodsMovementType = '601' or  d.GoodsMovementType = '602' )
                                                    and d.GoodsMovementIsCancelled = ''
                                                    ) 
{
   key a.Material,
    key a.Batch,
    key a.Plant,
    a.Customer,
    a.YARNRECEIVED as YARNRECEIVED,
    a.YARNRETURN as YARNRETURN,
    a.ProductDescription,
    a.MaterialBaseUnit,
    sum(b.QuantityInEntryUnit) as YarnConsuption,
    c.Material as FabricMaterial,
     @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'     
  sum( case when d.DebitCreditCode = 'H' 
       and ( d.GoodsMovementType = '601' )
       then  d.QuantityInBaseUnit  
       when  d.DebitCreditCode = 'S'
       and ( d.GoodsMovementType = '602' ) 
       then -1 * d.QuantityInBaseUnit  
       end ) as Dispatc_QTY
}
   group by
    a.Material,
    a.Batch,
    a.Plant,
    a.Customer,
    a.YARNRECEIVED,
    a.YARNRETURN,
    a.MaterialBaseUnit,
    c.Material,
    a.ProductDescription
