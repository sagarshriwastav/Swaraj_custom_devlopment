@AbapCatalog.sqlViewName: 'YFINALQM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Quality Insp Head'
define view ZPP_QUALITY_INSP_CDS_CHANGE as select from zpp_quality_item
{
    key srno as Srno,
    key matdoc_no as MatdocNo,
    key matdoc_year as MatdocYear,
    key refbatch as Refbatch,
    key zparameter as Zparameter,
    key qatestno as Qatestno,
    remark as Remark,
    zresult as Zresult,
    postingdate as Postingdate
}
