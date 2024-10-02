@AbapCatalog.sqlViewName: 'YTECOUOTSIDE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZTECO_OUTSIDE_CDS'
define view ZTECO_OUTSIDE_CDS as select from ztecotable as a
      left outer join ZPP_BEAMBOOK_SUMMERY_CDS as b on ( b.Beamno = a.beamno 
                                                        and b.Prodorder = a.proorder )
{
 key a.proorder as Proorder,
 key a.beamno as Beamno,
     a.plant as Plant,
     a.vendorcode as Vendorcode,
     a.beamgattingdate as Beamgattingdate,
     a.beamfalldate as Beamfalldate,
     b.Uom,
     @Semantics.quantity.unitOfMeasure : 'uom'
     b.Quantity
     
} where a.proorder is initial
