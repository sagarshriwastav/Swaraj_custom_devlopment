@AbapCatalog.sqlViewName: 'YPARAMETERS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_CHEMICAL_TEST_PARAMETR_CDS'
define view ZPP_CHEMICAL_TEST_PARAMETR_CDS as select from zpp_chemicl_tab2
{
    key partybillnumber as Partybillnumber,
    key sno as sno,
    key parmeters as parameters,
        zresult as zresult,
        remark as remark,
        status as status
    
       
}
