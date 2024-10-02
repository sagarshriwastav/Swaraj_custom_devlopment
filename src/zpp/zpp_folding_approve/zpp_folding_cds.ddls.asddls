@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_FOLDING_CDS FOR SERVIES'
define root view entity ZPP_FOLDING_CDS
  as select from    I_ManufacturingOrder as A
    left outer join zpp_fold_approve     as B on(
      B.sno = A.Batch
    )
    left outer join I_MfgOrderWithStatus as c on(
      c.ManufacturingOrder = A.ManufacturingOrder
    )
    left outer join I_SalesDocument as d on (  d.SalesDocument = A.SalesOrder )
    left outer join I_Customer as e on (   e.Customer = d.SoldToParty )


{
  key  A.PlanningPlant               as plant,
  key  A.Batch                       as BEAM_NO,
  key  B.sno                         as SNO,
  key  A.ManufacturingOrder          as Prod_order_no,
       A.CreationDate                as order_creation_date,
       A.Material,
       A.YY1_PartyBeam_ORD           as party_code,
       A.YY1_BeamGettingDate_ORD     as beam_getting_date,
       A. YY1_BeamFallDate_ORD       as beam_fall_date,
       A. ProductionUnit,
       @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
       A.MfgOrderPlannedTotalQty     as tragent_quantity,
       @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
       A. ActualDeliveredQuantity    as delivered_quantity,
       c.OrderIsTechnicallyCompleted,
       c.CreationDate,
       e.CustomerName,

       case when B.sno is not null or B.sno <> '' or B.sno is not initial
         then 'Approved' else '' end as TecoApproved

//           case when A.Batch is not null or A.Batch <> '' or A.Batch is not initial
//               then 'Approved' else '' end as TecoApproved

}
