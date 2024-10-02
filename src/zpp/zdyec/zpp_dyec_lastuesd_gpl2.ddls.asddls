@AbapCatalog.sqlViewName: 'YDYESLAST'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyec Last Used Gpl'
define view ZPP_DYEC_LASTUESD_GPL2 as select from zpp_dyec_chemica 

{
   
    key plant as Plant,
    key dyeingsort as Dyeingsort,
    key materialdocumentno ,
    materialdocumentyear as Materialdocumentyear,
    reciepeno,
    prodgpl as consqty,
    chemical
    
}   
    group by  

      plant,
      dyeingsort,
      materialdocumentno ,
      materialdocumentyear,
      reciepeno,
      prodgpl,
      chemical
