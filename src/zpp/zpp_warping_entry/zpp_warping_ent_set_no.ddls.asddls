@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Warping Entry Set No Cheack'
define root view entity ZPP_WARPING_ENT_SET_NO as select from ZPP_WARPING_ENTRY_CDS11

{
    key ZfsetNo
    
}   group by ZfsetNo
 