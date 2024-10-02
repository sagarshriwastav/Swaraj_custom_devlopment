@AbapCatalog.sqlViewName: 'YPLANTDY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Plant F4'
define view ZPP_PLANT_DYEING as select from ZPP_DYEINGR_CDS
{
   
       key Plant
}  
  group by 
       
        Plant
