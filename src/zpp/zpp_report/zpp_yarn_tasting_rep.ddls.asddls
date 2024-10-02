@AbapCatalog.sqlViewName: 'YARNTESTREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Tastiing Report'
define view ZPP_YARN_TASTING_REP as select from ZPP_YARN_HEAD_TEAST as a 
left outer join ZPP_YARN_ITAM_TEAST as b on ( b.Partybillnumber = a.Partybillnumber )
{
    key a.Batch,
    key a.Material,
    key a.Partybillnumber,
    a.Suppliername,
    a.Suppliercode,
    a.Matdesc,
    a.Vehiclenumber,
    a.Partybilldate,
    a.Postingdate,
    a.Plant,
    a.Stpragelocation,
    a.Millname,
    a.Lotnumber,
    a.Salesorder,
    a.Quantitybaseunit,
    a.Noofbags,
    a.Noofcones,
    a.Suppliercsp,
    a.Suppliercount,
    a.Suppliercspcvper,
    a.Suppliercountcvper,
    a.Remark,
    case when a.Status = '' then 'Pending' else 
    a.Status end as Status,
    b.Parmeters,
    b.Zresult
}
