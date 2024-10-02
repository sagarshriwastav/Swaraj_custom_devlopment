@AbapCatalog.sqlViewName: 'YCHANGEGREY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Change Grey Program'
define view ZPP_CHANGE_GREY_PROGRAM_CDS as select from zpp_grey_grn_tab
{
    key plant as Plant,
    key batch as Batch,
    key recbatch as Recbatch,
    key materialdocument101 as Materialdocument101,
    materialdocumentyear101 as Materialdocumentyear101,
    pick as Pick,
    netwt as Netwt,
    wtmtr as Wtmtr,
    ironpipe as Ironpipe,
    shadeno as Shadeno,
    remark as Remark,
    setno as Setno,
    grosswt as Grosswt
}
