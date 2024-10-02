@AbapCatalog.sqlViewName: 'YQTYLENGHT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Shrinkage Loom Entry  Report'
define view zmm_grey_receipt_DATA as select from zmm_grey_receipt as B
//left outer join I_MaterialDocumentItem_2 as A on ( A.MaterialDocument = B.matdocument 
//                                              and  A.MaterialDocumentYear = B.matdocumentyear
//                                              and  A.Batch = B.setnumber
//                                              )
{
   key setnumber ,
   key matdocument ,
   key matdocumentyear ,
     sum(qtylength )  as qtylength
     
}
// where A.GoodsMovementIsCancelled = ''
group by  
matdocument ,    
matdocumentyear ,
setnumber
          
          
           
          
         
         
       
