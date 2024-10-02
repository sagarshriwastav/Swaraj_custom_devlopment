@EndUserText.label: 'ZSD_HANGER_PRINT_CDS_PRO'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity ZSD_HANGER_PRINT_CDS_PRO 
provider contract transactional_query
as projection on ZSD_HANGER_PRINT_CDS

{
    key Style,
    Yarnspun,
    Width,
    Weight,
    Shade,
    Weave,
    Weftsnkg,
    Finshtype
}
