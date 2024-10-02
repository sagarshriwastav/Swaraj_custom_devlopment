@AbapCatalog.sqlViewName: 'YDYEING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Dyeing Entry Report'
define view ZPP_DYEINGR_CDS as select from zpp_dyeing1 as a  
      left outer join I_MaterialDocumentItem_2 as b on ( b.MaterialDocument = a.materialdocument 
                                                       and b.MaterialDocumentYear = a.materialdocumentyear 
                                                       and b.Material = a.material 
                                                       and b.Batch = a.beamno )
      inner join ymseg4 as C on ( C.MaterialDocument = b.MaterialDocument 
                                     and C.MaterialDocumentItem = b.MaterialDocumentItem
                                     and C.MaterialDocumentYear = b.MaterialDocumentYear)

{
    key a.plant as Plant,
    key a.setno as Setno,
    key a.beamno as Beamno,
    key a.material as Material,
    key a.materialdocument as Materialdocument,
    key b.MaterialDocumentItem as Materialdocumentitem,
    key a.materialdocumentyear as Materialdocumentyear,
    a.zorder as Zorder,
    a.hremark1 as Hremark1,
    a.hremark2 as Hremark2,
    a.pipenumber as Pipenumber,
    cast('M' as abap.unit( 3 ) ) as luom,
    cast('KG' as abap.unit( 3 ) ) as wuom,
    @Semantics.quantity.unitOfMeasure : 'luom'
    a.length as Length,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.netweight as Netweight,    
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.tareweight as Tareweight,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.grossweight as Grossweight,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.avgweight as Avgweight,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.unsizedwt as Unsizedwt,
    @Semantics.quantity.unitOfMeasure : 'Wuom'
    a.sizedwt as Sizedwt,
    a.shade as Shade,
    a.optname as Optname,
    a.shift as Shift,
    a.greyshort as Greyshort,
    a.remark as Remark,
    a.totends,
    b.PostingDate
}
