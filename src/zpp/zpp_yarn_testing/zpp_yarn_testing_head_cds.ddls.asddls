@AbapCatalog.sqlViewName: 'YARNTESTINGHEAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Testing Module Pool'
define view ZPP_YARN_TESTING_HEAD_CDS as select from zpp_yarn_testing
{
    key batch as Batch,
    key material as Material,
    key partybillnumber as Partybillnumber,
    suppliername as Suppliername,
    suppliercode as Suppliercode,
    matdesc as Matdesc,
    vehiclenumber as Vehiclenumber,
    partybilldate as Partybilldate,
    postingdate as Postingdate,
    plant as Plant,
    stpragelocation as Stpragelocation,
    millname as Millname,
    lotnumber as Lotnumber,
    salesorder as Salesorder,
    quantitybaseunit as Quantitybaseunit,
    noofbags as Noofbags,
    noofcones as Noofcones,
    suppliercsp as Suppliercsp,
    suppliercount as Suppliercount,
    suppliercspcvper as Suppliercspcvper,
    suppliercountcvper as Suppliercountcvper,
    remark as Remark,
    status as Status,
    testingdate as Testingdate
}
