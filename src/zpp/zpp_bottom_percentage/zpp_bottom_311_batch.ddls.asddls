@AbapCatalog.sqlViewName: 'YB311'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BOTTOM_311_BATCH'
define view ZPP_BOTTOM_311_BATCH as select from I_MfgOrderDocdGoodsMovement as A
                   inner join I_MaterialDocumentItem_2 as b  on (  b.Batch = A.Batch 
                                       and b.GoodsMovementType = '311' and b.GoodsMovementIsCancelled = '' and b.Material = A.Material 
                                       and b.MaterialDocumentItem = A.GoodsMovementItem
                                       and b.MaterialDocument = A.GoodsMovement  )
                 

                                       
            
{
    key A.SalesOrder ,
    key A.SalesOrderItem , 
    key A.Material as Cotton_Yarn  ,  
    key A.ManufacturingOrder as orderid ,
    key A.Batch ,
        A.QuantityInBaseUnit as Issue_Cotton_Yarn,
//        A.PostingDate,
        A.GoodsMovementType
//        C.Material as Cotton_Yarn ,
//        C.QuantityInBaseUnit as Issue_Cotton_Yarn
        
       
   
}

where  A.GoodsMovementType = '311'
and A.Material like 'YGPCO%'
// or A.Material like 'YGPCO%  
