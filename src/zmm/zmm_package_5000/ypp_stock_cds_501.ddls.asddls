@AbapCatalog.sqlViewName: 'YCDS1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'STOCK CDS GOOSMOVENTTYPE501'
define view YPP_STOCK_CDS_501 as select from  I_MaterialDocumentItem_2  as Master 
         inner join ymseg4 as REV on (REV.MaterialDocument = Master.MaterialDocument 
                                      and REV.MaterialDocumentItem = Master.MaterialDocumentItem 
                                      and REV.MaterialDocumentYear = Master.MaterialDocumentYear )
{
 key Master.Material,
 key Master.Plant,
 key Master.StorageLocation,
 Master.Batch,
 Master.GoodsMovementType,
 Master.MaterialBaseUnit,  
 Master.PostingDate,
 Master.MaterialDocument,
 Master.Customer
// MaterialDocument,
// Customer    
}

where Master.Batch != ''  and ( Master.GoodsMovementType = '501' or Master.GoodsMovementType = '502' ) 
//where Plant = '1300'   and ( GoodsMovementType = '501' or GoodsMovementType = '502' )
