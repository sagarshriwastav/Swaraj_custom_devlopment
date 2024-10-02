@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Trolly Set No F4'
define root view entity ZPP_TROLLY_SET_NO_F4 as select from I_MaterialStock_2


{
    
    key Batch ,   
    key Plant,
        substring(Batch,1,7) as SetNo

} where Plant = '1200' and StorageLocation = 'FN01' 
  
   group by Batch,
            Plant
            
