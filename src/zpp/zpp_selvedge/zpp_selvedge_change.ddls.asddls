@AbapCatalog.sqlViewName: 'YSELVEDGECHN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Selvedge Screen'
define view ZPP_SELVEDGE_CHANGE as select from zpp_selvedge_tab
{
    key srno as Srno,
    key plant as Plant,
    key beamno as Beamno,
    key selvedge as Selvedge,
    key orderno as Orderno,
    material as Material,
    materialdesc as Materialdesc,
    remark
}
