@EndUserText.label: 'ZBOM & MASTER PROJ'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define root view entity zbom_mcp_PROJ
 provider contract transactional_query
 as projection on zbom_mcp_CDS

{
    key Werks,
    key FromDate,
    key ToDate,
    unit_field,
    WarpQty,
    WeftQty,
    SelvedgeQty
}
