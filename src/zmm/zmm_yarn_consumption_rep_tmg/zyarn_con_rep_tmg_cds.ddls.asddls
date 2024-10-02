@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Data Defination For Yarn Consume Report TMG'
define root view entity ZYARN_CON_REP_TMG_CDS as select from zyarnco_rep_tmg
{
    key material as Material,
    denier as Denier
}
