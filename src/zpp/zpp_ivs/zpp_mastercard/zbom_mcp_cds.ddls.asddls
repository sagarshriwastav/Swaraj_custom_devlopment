@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BOM & MASTER CARD CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
 }
define root view entity zbom_mcp_CDS as select from zbom_mcp

{
    key werks as Werks,
    key from_date as FromDate,
    key to_date as ToDate,
    unit_field,
    @Semantics.quantity.unitOfMeasure : 'unit_field'
    warp_qty as WarpQty,
    @Semantics.quantity.unitOfMeasure : 'unit_field'
    weft_qty as WeftQty,
    @Semantics.quantity.unitOfMeasure : 'unit_field'
    selvedge_qty as SelvedgeQty
}
