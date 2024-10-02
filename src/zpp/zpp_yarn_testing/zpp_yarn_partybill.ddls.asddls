@AbapCatalog.sqlViewName: 'YCHEACKPARTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Partybill Chack'
define view ZPP_YARN_PARTYBILL as select from zpp_yarn_testing
{
   
    key partybillnumber as Partybillnumber,
    key suppliercode ,
    key postingdate,
    plant as Plant
    
}  
   group by  
   
      partybillnumber,
      postingdate,
      suppliercode ,
      plant
