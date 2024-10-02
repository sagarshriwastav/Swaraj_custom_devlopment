@AbapCatalog.sqlViewName: 'YBOTTO'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS FOR PERCENTAGE'
define view ZPP_PERCENTAGE_CDS as select from  I_MfgOrderDocdGoodsMovement as A
                   inner join I_MaterialDocumentItem_2 as b  on (  b.OrderID = A.ManufacturingOrder 
                                       and b.GoodsMovementType = '101' and b.GoodsMovementIsCancelled = '' and b.Material = A.Material 
                                       and b.MaterialDocumentItem = A.GoodsMovementItem
                                       and b.MaterialDocument = A.GoodsMovement  and  A.GoodsMovementType = '101' and A.Material like 'BW%' )
           
//     left outer join  ZPP_MCARDR_CDS as i on ( i.dyesort = f.Material and i.Type = 'Warp' )
     
                

                                       
            
{
    key A.SalesOrder ,
    key A.SalesOrderItem 
      
}
