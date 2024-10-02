@AbapCatalog.sqlViewName: 'YITEMYARN'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Testing Module Pool'
define view ZPP_YARN_TESTTEM_CDS as select from zpp_yarn_testtem
{
    key partybillnumber as Partybillnumber,
    key sno as Sno,
    key parmeters as Parmeters,
     zresult as Zresult,
    remark as Remark,
    status as Status
}
