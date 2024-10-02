@EndUserText.label: 'qcd proj'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zqcd_proj 
 provider contract transactional_query
 as projection on zqcd_cds
{
    key Cbcode,
    Cgcode,
    Rescnt,
    Maktx,
    Waste,
    Erdat,
    Ernam
}
