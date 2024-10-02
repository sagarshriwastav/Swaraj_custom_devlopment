@AbapCatalog.sqlViewName: 'YDYEINGSHADE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyeing Shade Tmg'
define view ZPP_DYEING_SHADE_TMG as select from zpp_dye_shad_tmg
{
    key srno as Srno,
    key dyeingshade as Dyeingshade,
        dyeindesc,
    created_by as CreatedBy,
    created_at as CreatedAt
    
}
