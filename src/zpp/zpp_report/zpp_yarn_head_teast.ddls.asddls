@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds for yarn tasting header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPP_YARN_HEAD_TEAST as select from zpp_yarn_testing as a
                  left outer join ZPP_YARN_PARAMET_TEST as b on ( b.Partybillnumber = a.partybillnumber  and b.partycode = a.suppliercode )
{
    key a.batch as Batch,
    key a. material as Material,
    key a.partybillnumber as Partybillnumber,
//    key b.partycode,
    a.suppliername as Suppliername,
    a.suppliercode as Suppliercode,
    a.matdesc as Matdesc,
    a.vehiclenumber as Vehiclenumber,
    a.partybilldate as Partybilldate,
    a.postingdate as Postingdate,
    a.plant as Plant,
    a.stpragelocation as Stpragelocation,
    a.millname as Millname,
    a.lotnumber as Lotnumber,
    a.salesorder as Salesorder,
    a.quantitybaseunit as Quantitybaseunit,
    a.noofbags as Noofbags,
    a.noofcones as Noofcones,
    a.suppliercsp as Suppliercsp,
    a.suppliercount as Suppliercount,
    a.suppliercspcvper as Suppliercspcvper,
    a.suppliercountcvper as Suppliercountcvper,
    a.remark as Remark,
    a.status as Status,
    a.testingdate,
    b.ActualCount,
    b.MINCOUNT,
    b.MAXCOUNT,
    b.CountCVper,
    b.CSP,
    b.MINCSP,
    b.MAXCSP,
    b.CSPCVper
    
}
