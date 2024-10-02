@AbapCatalog.sqlViewName: 'YPPCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Final Quality'
define view ZPP_QM_CODE_CDS as select from zqm_code

{
    key serialno as Serialno,
    zparameter as Zparameter
   
}
