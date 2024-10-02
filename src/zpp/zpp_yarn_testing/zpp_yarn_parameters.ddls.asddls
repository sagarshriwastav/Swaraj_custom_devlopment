@AbapCatalog.sqlViewName: 'YARNTMG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Parameters Tmg'
define view ZPP_YARN_PARAMETERS as select from ytest_parameters
{
    key plant as Plant,
    key srno as Srno,
    key progaram as Progaram,
    key progaramno as Progaramno,
    key progaramname as Progaramname,
    key parameters as Parameters
}
