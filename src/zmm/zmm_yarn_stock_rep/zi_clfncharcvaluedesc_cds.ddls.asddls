@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Yarn Wise  Report'
define root view entity ZI_ClfnCharcValueDesc_cds as select from I_ClfnCharcValue as a  
       left outer join I_ClfnCharcValueDesc as C on ( C.TimeIntervalNumber = a.TimeIntervalNumber 
                                                      and C.CharcValuePositionNumber = a.CharcValuePositionNumber 
                                                      and C.CharcInternalID = a.CharcInternalID
                                                      and C.Language = 'E' ) 
                                                      
 {     
       key a.CharcInternalID,
       a.CharcValue as mil,
       C.CharcValueDescription,
       C.Language
 
 }                                                     
   
