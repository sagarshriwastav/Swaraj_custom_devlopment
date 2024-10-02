@AbapCatalog.sqlViewName: 'Y261'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BOTTOM_PERCENTAGE_261'
define view ZPP_BOTTOM_PERCENTAGE_261 as select from  I_MaterialDocumentItem_2 
                                              
{
    key Material as Cotton_Yarn  ,  
    key Batch ,
    key OrderID,
        QuantityInBaseUnit as Issue_Cotton_Yarn
//        A.PostingDate,
//        C.Material as Cotton_Yarn ,
//        C.QuantityInBaseUnit as Issue_Cotton_Yarn
        
       
   
}

where  GoodsMovementType = '261'
and    Material like 'YGPC%' and GoodsMovementIsCancelled = ''
// or A.Material like 'YGPCO%  
