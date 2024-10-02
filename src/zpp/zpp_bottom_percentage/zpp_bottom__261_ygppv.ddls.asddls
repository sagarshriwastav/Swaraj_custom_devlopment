@AbapCatalog.sqlViewName: 'YGPPV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BOTTOM__261_YGPPV'
define view ZPP_BOTTOM__261_YGPPV as select from  I_MaterialDocumentItem_2 
                                              
{
    key Material as PV_Yarn  ,  
    key Batch ,
    key OrderID,
        QuantityInBaseUnit as Issue_PV_Yarn
               
   
}

where  GoodsMovementType = '261'
and    Material like 'YGPPV%' and GoodsMovementIsCancelled = '' 
