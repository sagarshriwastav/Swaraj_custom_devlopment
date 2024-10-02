@EndUserText.label: 'Projaction Data Defination For Yarn Consume TMG'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZYARN_CON_TMG_PJ_CDS 
provider contract transactional_query
as projection on ZYARN_CON_TMG_CDS
{
    key Fabric,
    key Yarn,
    key Pick
}
