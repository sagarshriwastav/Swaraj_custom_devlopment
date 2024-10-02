@EndUserText.label: 'Projaction Data Defination For Z543_APPROVEL'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity Z543_APPROVEL_CDSPR
provider contract transactional_query
 as projection on Z543_APPROVEL_CDS
{
    key Batch,
    key Weft
}
