@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Selevedge Cds For Master Card Screen'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
 }
define root view entity ZPC_SELVEDGE_CDS as select from zpc_selvedge

{
    key zpno as Zpno,
    key zpmsno as Zpmsno,
 //   key zsalign as Zsalign,
    zpmtype as Zpmtype,
    zpmcountsys as Zpmcountsys,
    rescnt as Rescnt,
    zpmyqlty as Zpmyqlty,
    maktx as Maktx,
    shaft as Shaft,
    dent as Dent,
    dent1 as Dent1,
    ends as Ends,
    repeats as Repeats,
    mul as Mul,
    totalends as Totalends,
    pmdesc as Pmdesc,
    shades as Shades,
    mark as Mark,
    wpmtr as Wpmtr,
    icon as Icon,
    center as Center
}
