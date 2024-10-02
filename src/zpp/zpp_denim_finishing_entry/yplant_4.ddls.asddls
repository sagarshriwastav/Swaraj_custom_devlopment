//@AbapCatalog.sqlViewName: 'ZPLANT'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PLANT'
define root view  entity YPLANT_4 as select from I_Plant
 {
    
    key Plant,
    PlantName 

}   group by 
    Plant,
    PlantName 
