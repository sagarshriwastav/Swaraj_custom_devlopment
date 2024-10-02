@AbapCatalog.sqlViewName: 'YLASTGPL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyec Last Used Gpl'
define view ZPP_DYEC_LASTUESD_GPL as select from zpp_dyec_chemica
{
   
    key plant as Plant,
    key dyeingsort as Dyeingsort,
    key max(materialdocumentno ) as Materialdocumentno,
    materialdocumentyear as Materialdocumentyear
  //  consqty,
  //  chemical
    
}   
    group by  

      plant,
      dyeingsort,
      materialdocumentyear
 //     consqty,
 //     chemical
     
