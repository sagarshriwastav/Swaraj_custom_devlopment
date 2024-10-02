@AbapCatalog.sqlViewName: 'YPLANTF4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Selvedge Plant 4'
define view ZPP_SELVEDGE_PLANT_F4 as select from ZPP_SELVEDGE_CDS
{
   
    key ProductionPlant
}  

 group by  
    ProductionPlant
