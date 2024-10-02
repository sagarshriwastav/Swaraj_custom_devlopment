@AbapCatalog.sqlViewName: 'YITEMQUALITY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Final Item Quality Report'
define view ZPP_QUALITY_INSP_ITEM_CDS as select from zpp_quality_item
{
    key srno as Srno,
    key matdoc_no as MatdocNo,
    key matdoc_year as MatdocYear,
    key refbatch as Refbatch,
    key zparameter as Zparameter,
    key qatestno  as qatestno,
    remark as Remark,
    zresult as Zresult,
    postingdate as Postingdate
}
