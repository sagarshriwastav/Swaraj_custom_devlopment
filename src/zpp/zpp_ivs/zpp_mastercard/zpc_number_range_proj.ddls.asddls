@EndUserText.label: ' pc number range proj'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zpc_number_range_PROJ 
 provider contract transactional_query
 as projection on zpc_number_range_cds
{
    key Werks,
    key Zpbrand,
        Curzpno 
}
  
