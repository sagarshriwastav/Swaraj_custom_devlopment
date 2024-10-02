@AbapCatalog.sqlViewName: 'YBEAMPROGRA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Beam Program'
define view ZPP_BEAM_PROGRAM_CHNG as select from zpp_beam_pro_tab  as a 
        inner  join I_ProductDescription as b on ( b.Product = a.material and b.Language = 'E' )
        left outer join I_ManufacturingOrderItem as c on ( c.ManufacturingOrder = a.orderno )
{
    key a.beamno as Beamno,
    key a.orderno as Orderno,
    key a.material as Material,
    a.zplant,
    a.zdate as Zdate,
    a.zunit as Zunit,
    a.beammtr as Beammtr,
    c.ProductionUnit,
    c.MfgOrderPlannedTotalQty as Pomtr,
    b.ProductDescription
}
