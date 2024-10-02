@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Defination For Yarn Consume TMG'
define root view entity ZYARN_CON_TMG_CDS as select from zyarn_con_tmg
{
    key fabric as Fabric,
    key yarn as Yarn,
    key pick as Pick
}
