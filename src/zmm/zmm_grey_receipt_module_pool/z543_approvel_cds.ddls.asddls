@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Defination For Z543_APPROVEL'
define root view entity Z543_APPROVEL_CDS as select from z543_approvel
{
    key batch as Batch,
    key weft as Weft
}
 