@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds JobChallan Print Screen F4 DelNumber'
define root view entity ZSD_CHALLAN_PRINT_F4_CDS2 as select from I_DeliveryDocument

{
    
    key DeliveryDocument

} 
   group by 
          DeliveryDocument
