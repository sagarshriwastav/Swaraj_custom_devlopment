@AbapCatalog.sqlViewName: 'YDYEINGSET'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_SETWISE_DYEING_CDS'
define view ZPP_SETWISE_DYEING_CDS as select from ZPP_DYEINGR_CDS
{
    key Material as SortNo,
        Setno,
        PostingDate,
        Beamno,
        luom,
        @Semantics.quantity.unitOfMeasure : 'luom'
        Length,
        Remark,
        Greyshort,
        wuom,
        @Semantics.quantity.unitOfMeasure : 'Wuom'
        Netweight as Netweight,    
        @Semantics.quantity.unitOfMeasure : 'Wuom'
        Tareweight as Tareweight,
        @Semantics.quantity.unitOfMeasure : 'Wuom'
        Grossweight as Grossweight
        
       
}
