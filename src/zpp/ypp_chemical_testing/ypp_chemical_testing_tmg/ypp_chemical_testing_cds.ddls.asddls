@AbapCatalog.sqlViewName: 'ZCHEMC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YPP_CHEMICAL_TESTING_CDS'
define view YPP_CHEMICAL_TESTING_CDS as select from ychemicl_prametr
{
    key plant as Plant,
    key srno as Srno,
    key progaram as Progaram,
    key progaramno as Progaramno,
    key progaramname as Progaramname,
    key parameters as Parameters,
    local_created_by as LocalCreatedBy,
    local_created_at as LocalCreatedAt,
    local_last_changed_by as LocalLastChangedBy,
    local_last_changed_at as LocalLastChangedAt,
    last_changed_at as LastChangedAt
}
