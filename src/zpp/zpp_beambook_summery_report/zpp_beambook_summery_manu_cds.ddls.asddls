@AbapCatalog.sqlViewName: 'YMANUBEAM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BEAMBOOK_SUMMERY_MANU_CDS'
define view ZPP_BEAMBOOK_SUMMERY_MANU_CDS as select from I_ManufacturingOrder
{
    key Material,
        ProductionUnit,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        sum(MfgOrderPlannedTotalQty) as MfgOrderPlannedTotalQty,
        ManufacturingOrder
        
}
   group by Material,
            ProductionUnit,
            ManufacturingOrder
