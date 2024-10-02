@AbapCatalog.sqlViewName: 'YTAB2CHEMICAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'pp chemical testing tab2 cds'
define view ZPP_CHEMICAL_TESTTAB2_CDS as select from zpp_chemicl_tab2
{
    key partybillnumber as Partybillnumber,
    key sno as Sno,
    key parmeters as Parmeters,
    zresult as Zresult,
    remark as Remark,
    status as Status
}
