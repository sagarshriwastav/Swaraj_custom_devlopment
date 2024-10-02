@AbapCatalog.sqlViewName: 'YCHEMICLTESTHEAD'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'pp chemical testing head cds'
define view ZPP_CHEMICAL_TESTING_HEAD_CDS as select from zpp_chemical_tab
{
    key batch as Batch,
    key material as Material,
    key partybillnumber as Partybillnumber,
    suppliername as Suppliername,
    suppliercode,
    matdesc as Matdesc,
    vehiclenumber as Vehiclenumber,
    partybilldate as Partybilldate,
    postingdate as Postingdate,
    plant as Plant,
    stpragelocation as Stpragelocation,
    lotno,
    quantitybaseunit as Quantitybaseunit,
    noofbags as Noofbags,
    purchaseorder,
    purchaseorderdate,
    hsn,
    gateno,
    materialdocumentyear,
    charcvaluedescription as millname,
    testing,
    prquantity,
    orderquantity
}
