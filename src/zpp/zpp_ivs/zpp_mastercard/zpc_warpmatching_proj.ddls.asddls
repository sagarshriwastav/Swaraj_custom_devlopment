@EndUserText.label: 'pc warpmatching proj'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zpc_warpmatching_proj  
 provider contract transactional_query
  as projection on zpc_warpmatching_cds
{
   key Zpno,
   Zmatch,
   Zpmsno 
}
