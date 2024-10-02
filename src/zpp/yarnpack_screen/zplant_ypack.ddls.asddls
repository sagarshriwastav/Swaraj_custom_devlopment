@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPLANT_YPACK'
define root view  entity ZPLANT_YPACK as select from I_Plant
 {
    
    key Plant,
    PlantName 
}
