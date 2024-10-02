@AbapCatalog.sqlViewName: 'ZPPCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyeing Entry Report'
define view ZPP_DYEING_CDS as select from zpp_dyeing1

{
    key plant as Plant,
    key setno as Setno,
    key beamno as Beamno,
    key material as Material,
    key materialdocument,
    key materialdocumentyear,
    zorder as Zorder,
    hremark1 as Hremark1,
    hremark2 as Hremark2,
    pipenumber as Pipenumber,
    @Semantics.quantity.unitOfMeasure : 'luom'
    length as Length,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    netweight as Netweight,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    tareweight as Tareweight,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    grossweight as Grossweight,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    unsizedwt as unsizedwt,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    sizedwt as  sizedWt,
    luom,
    wuom,
    totends as Totalends,
    shade as Shade,
    optname as Optname,
    shift as Shift,
    greyshort as Greyshort,
    remark as Remark
}
