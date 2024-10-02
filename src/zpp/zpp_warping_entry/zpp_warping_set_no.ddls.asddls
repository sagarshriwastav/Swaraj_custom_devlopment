@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Warping Entry Set No F4'
define root view entity ZPP_WARPING_SET_NO as select from ZDNM_DD

{
   key ZfsetNo    

}  group by  ZfsetNo
 