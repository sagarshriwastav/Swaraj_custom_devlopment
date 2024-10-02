@EndUserText.label: ' pc monogram PROJ'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zpc_monogram_PROJ  
 provider contract transactional_query
 as projection on  zpc_monogram_CDS
{
    key Zpno,
    key Zpmsno,
    Zpmmonog,
    Zpmsaveas,
    Zpmlength,
    Zpmmktordno,
    Zpmremarks,
    Mark,
    Zname,
    Kunnr
}
