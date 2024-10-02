@AbapCatalog.sqlViewName: 'YABACD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Batch Count'
define view ZMM_GREY_RECEIPT_BATCH_COUNT as select from I_MaterialDocumentItem_2 
{
    key Batch,
   ( count( * ) + 1 ) as PcsNo
}  
  where GoodsMovementType = '543'
   group by 
     Batch
      
