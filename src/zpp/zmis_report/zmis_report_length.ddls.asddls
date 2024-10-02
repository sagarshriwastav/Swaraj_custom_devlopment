@AbapCatalog.sqlViewName: 'YDYEING_MIS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMIS_REPORT_LENGTH'
define view ZMIS_REPORT_LENGTH as select from ZPP_DYEINGR_CDS
{
    key Setno,
        Material as DyeingSort,
        luom,
        @Semantics.quantity.unitOfMeasure : 'luom'
        sum(Length) as Length ,
        wuom,
        @Semantics.quantity.unitOfMeasure : 'wuom'
        sum(Sizedwt) as Weight
} 
   group by Setno,
            Material,
            luom,
            wuom
