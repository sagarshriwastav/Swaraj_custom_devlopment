@AbapCatalog.sqlViewName: 'YGREYREC543'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Shrinkage Loom Entry Grey Reciept'
define view ZPP_SHRINKAGE_LOOM_GREYREC_541 as select from I_MaterialDocumentItem_2 as A
 left outer  join ZI_MaterialDocumentItem_2 as B on  (  B.setnumber = A.Batch  )
// inner join zmm_grey_receipt_DATA as B on  (  B.setnumber = A.Batch  )
{
    key A.Batch,
        B.qtylength  as GreyReceiveMtr,
         B.qtylength    as qtylength,
         A.PurchaseOrder
      
  //  A.GoodsMovementIsCancelled
      
 
 } 
  where A.GoodsMovementType = '101' 
//   and GoodsMovementRefDocType = 'B'
//and A.GoodsMovementIsCancelled = ''
   group by A.Batch,
           B.qtylength,
            A.PurchaseOrder
           
   
