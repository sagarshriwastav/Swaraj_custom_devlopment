@EndUserText.label: 'Projaction Data Defination For Yarn Consume Report TMG'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZYARN_CON_REP_TMG_PJ_CDS  
provider contract transactional_query 
as projection on ZYARN_CON_REP_TMG_CDS
{
    key Material,
    Denier
}
