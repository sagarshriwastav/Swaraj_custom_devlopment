@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZSD_HANGER_PRINT_CDS'
define root view entity ZSD_HANGER_PRINT_CDS as select from zsd_hanger_tab
{
   key style as Style,
    yarnspun as Yarnspun,
    width as Width,
    weight as Weight,
    shade as Shade,
    weave as Weave,
    weftsnkg as Weftsnkg,
    finshtype as Finshtype
}
