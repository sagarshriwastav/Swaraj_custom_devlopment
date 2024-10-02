@AbapCatalog.sqlViewName: 'YCHECKCHEMICLPAR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'pp chemical partybill'
define view ZPP_CHEMICAL_PARTYBILL as select from zpp_chemical_tab
{
   
    key partybillnumber as Partybillnumber,
    key suppliercode ,
    plant as Plant
    
}  
   group by  
   
      partybillnumber,
      suppliercode ,
      plant
