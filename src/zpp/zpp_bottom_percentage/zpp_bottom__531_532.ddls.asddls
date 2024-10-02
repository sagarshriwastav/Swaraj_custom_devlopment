@AbapCatalog.sqlViewName: 'Y531'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BOTTOM__531_532'
define view ZPP_BOTTOM__531_532 as select from  I_MfgOrderDocdGoodsMovement as A
                   inner join I_MaterialDocumentItem_2 as b  on (  b.OrderID = A.ManufacturingOrder 
                                       and ( b.GoodsMovementType = '532' or  b.GoodsMovementType = '531' )
                                        and b.GoodsMovementIsCancelled = '' and b.Material = A.Material 
                                       and b.MaterialDocumentItem = A.GoodsMovementItem
                                       and b.MaterialDocument = A.GoodsMovement  )
                 

                                       
            
{
    key A.SalesOrder ,
    key A.SalesOrderItem , 
    key A.Material as Bottom_Sort  ,  
    key A.ManufacturingOrder as orderid ,
    key A.Batch ,
        A.QuantityInBaseUnit as Bottom
//        A.PostingDate,
//        C.Material as Cotton_Yarn ,
//        C.QuantityInBaseUnit as Issue_Cotton_Yarn
        
       
   
}

where  A.GoodsMovementType = '531' or A.GoodsMovementType = '532'
and A.Material like 'WW%' and b.GoodsMovementIsCancelled = ''
// or A.Material like 'YGPCO%  
