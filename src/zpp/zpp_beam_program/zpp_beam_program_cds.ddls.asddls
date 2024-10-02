@AbapCatalog.sqlViewName: 'YBEAMPROGRAM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Beam Program'
define view ZPP_BEAM_PROGRAM_CDS as select from ZPP_BEAM_PROGRAM_CHNG1 as a 
                  
{   
    key a.ManufacturingOrder,
    key a.Batch,
    key a.Material,   
        a.plant,
        a.ProductionPlant,  
        a.ProductionUnit,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        a.TargetQty as TargetQty,
        a.UnloadingQty,
        a.ProductDescription,
        a.CHmaterial,
        a.OrderIsReleased,
        a.OrderIsDeleted
         
}  where ( a.CHmaterial = '' or a.CHmaterial is null )and a.OrderIsDeleted is initial 
 