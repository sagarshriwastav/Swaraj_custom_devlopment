@AbapCatalog.sqlViewName: 'Y541POSTINGDATE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Weft Transfer Report'
define view YLATEST_541_POSTING_DATE as select from I_MaterialDocumentItem_2 
{
    key Batch,
        Material,
        Plant,
        max(PostingDate ) as LatestDate
        
}  where GoodsMovementType = '541' and DebitCreditCode = 'S'
   group by  
     Batch,
     Material,
     Plant
