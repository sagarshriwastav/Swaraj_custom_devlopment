@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For F4 Trolly Screen'
define root view entity ZPP_TROLLY_SET_NO_F4_1 as select from ZPP_TROLLY_SET_NO_F4
 
{
  
    key Plant,
    SetNo
}   group by
       Plant,
       SetNo
