@AbapCatalog.sqlViewName: 'YMAXMATREC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Report'
define view ZMM_GREY_RECEIPT_MAX_PIECE as select from zmm_grey_receipt
{
    key piecenumber ,
    key itemcode ,
    key max( matdocument ) as matdocument,
    key matdocumentyear
     //max(setnumber) as setnumber,
    //max( partychlaan ) as partychlaan,
    //max(  loom ) as  loom 
} 
  group by  
  
   piecenumber ,
   itemcode ,
   matdocumentyear
   //setnumber,
   //partychlaan,
   //loom
