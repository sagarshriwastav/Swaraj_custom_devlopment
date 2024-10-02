@AbapCatalog.sqlViewName: 'YFRCMTR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loom Wise Damage Frc Mtr'
define view ZPP_LOOMWISE_DAMAGE_FRC_MTR as select from I_MaterialDocumentItem_2 as a
{
    key a.Material,
    key a.Plant,
    key a.PostingDate,
        a.MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        sum(a.QuantityInEntryUnit) as FrcMtr
}  where a.GoodsMovementType = '201' and a.GoodsMovementIsCancelled = ''
    group by 
        a.Material,
        a.Plant,
        a.PostingDate,
        a.MaterialBaseUnit
