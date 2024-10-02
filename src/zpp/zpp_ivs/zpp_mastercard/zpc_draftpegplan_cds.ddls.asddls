@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Draftpegpllan Cds For Master Card Screen'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZPC_DRAFTPEGPLAN_CDS as select from zpc_draftpegplan
{
    key zpno as Zpno,
    key pmgroup as Pmgroup,
    key ptype as Ptype,
    key zpmsno as Zpmsno,
    pmdesc as Pmdesc,
    mul as Mul,
    repeats as Repeats,
 //   mark as Mark,
 //   repeats1 as Repeats1,
 //   mul1 as Mul1,
    remark as Remark
}
