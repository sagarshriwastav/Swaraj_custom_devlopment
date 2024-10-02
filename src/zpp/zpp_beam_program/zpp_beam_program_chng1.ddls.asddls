@AbapCatalog.sqlViewName: 'YBEAMPROGRAMCHG'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Beam Program'
define view ZPP_BEAM_PROGRAM_CHNG1 as select from I_ManufacturingOrderItem as a 
                   inner  join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
                   left outer join ZPP_BEAM_PROGRAM_CHNG as c on (  c.Beamno = a.Batch and c.Orderno = a.ManufacturingOrder )
                   left outer join I_ManufacturingOrder as d on (d.ManufacturingOrder = a.ManufacturingOrder )

{   
    key a.ManufacturingOrder,
    key a.Batch,
    key a.Material,
        a.ProductionPlant as plant,
        a.ProductionPlant,
        a.ProductionUnit,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        a.MfgOrderPlannedTotalQty as TargetQty,
        a.UnloadingPointName as UnloadingQty,
        b.ProductDescription,
        c.Material as CHmaterial,
        a.OrderIsReleased,
        d.IsMarkedForDeletion as OrderIsDeleted
        
} where ( a.ManufacturingOrderType = 'SWV1' or a.ManufacturingOrderType = 'JWV1' 
         or a.ManufacturingOrderType = 'MWV1' or a.ManufacturingOrderType = 'MJW1') and
           ( a.ProductionPlant = '1300' or a.ProductionPlant = '2100' ) 
