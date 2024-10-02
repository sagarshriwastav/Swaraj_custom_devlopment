@AbapCatalog.sqlViewName: 'YBEAM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_BEAMBOOK_SUMMERY_CDS'
define view ZPP_BEAMBOOK_SUMMERY_CDS as select from ZPP_GREY_GRN_REPORT as a
         left outer join ZPP_BEAMBOOK_SUMMERY_MANU_CDS as b on ( b.ManufacturingOrder = a.Prodorder )
         left outer join ZPP_BEAMBOOK_QUANTITY_CDS as c on  ( c.Prodorder = a.Prodorder )
         left outer join I_ManufacturingOrder as D on  ( D.ManufacturingOrder = a.Prodorder and D.Material = a.Material )
         left outer join ZPP_MCARDR_CDS as E on  ( E.zpno = D.YY1_MasterNumber_ORD and E.zpqlycode = D.Material )
{
   key 
   a.Plant,
   a.Material,
   a.Prodorder,
   a.Materialdec,
   a.Batch as Beamno,
   a.Partybeam,
   a.Partyname,
   a.Loomno,
   E.zppicks as Pick,
   a.Salesord,
   a.Salesorderitem,
   a.setno,
 //  a.Uom,
   cast( case when a.Uom = '' then 'M'  else  a.Uom end as  abap.unit( 3 ) ) as  Uom ,
   @Semantics.quantity.unitOfMeasure : 'uom'
   sum(a.Quantity) as Quantity,
   b.ProductionUnit,
   @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
   b.MfgOrderPlannedTotalQty,
   c.Uom as Uom1,
   @Semantics.quantity.unitOfMeasure : 'uom'
   c.Quantity as Quantity1,
  
   D.YY1_BeamFallDate_ORD,
   D.YY1_BeamGettingDate_ORD
   
}   group by  
               a.Plant,
               a.Material,
               a.Prodorder,
               a.Materialdec,
               a.Batch,
               a.Partybeam,
               a.Partyname,
               a.Loomno,
//               a.Pick,
               a.Salesord,
               a.Salesorderitem,
               a.setno,
               a.Uom,
               b.ProductionUnit,
               b.MfgOrderPlannedTotalQty,
               c.Uom,
               c.Quantity,
   D.YY1_BeamFallDate_ORD,
   D.YY1_BeamGettingDate_ORD,
   E.zppicks
