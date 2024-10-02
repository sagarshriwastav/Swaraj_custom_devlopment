@AbapCatalog.sqlViewName: 'ZMAXDOCUMENT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyec Last Used Gpl'
define view ZPP_MATERIALDOCUMENTITEM as select from I_MaterialDocumentItem_2 as a
{
   
    key a.Plant as Plant,
    key a.Batch as Batch,
    key a.Material,
    key max(a.MaterialDocument ) as Materialdocumentno, 
    key max( a.MaterialDocumentYear ) as Materialdocumentyear
    
}   where a.DebitCreditCode = 'H' 
    group by  

      a.Plant,
      a.Batch,
      a.Material
