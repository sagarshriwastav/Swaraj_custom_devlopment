@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Warping Entry Module Pool'
define root view entity ZPP_WARPING_ENTRY_CDS as select from ZDNM_DD  as a 
  //  left outer join ZPP_WARPING_ENTRY_CDS11 as b on ( b.ZfsetNo = a.ZsetNo and b.ZmcNo = a.ZmcNo )
    left outer join ZPC_HEADERMASTER_CDS as c on ( c.DyeSort = a.material )
    left outer join zpp_sortmaster as d on ( d.dyeingsort = a.material)
    left outer join zpp_approval_tab as e on ( e.setnumber = a.ZfsetNo and e.programno = '01' )
    left outer join I_ManufacturingOrder as F on ( F.Batch = a.ZfsetNo  )

{

    key a.ZmcNo,
    key a.ZfsetNo,
        a.UnitField,
        a.Zlength,
        a.material,
//        b.Ends, 
//        b.Beamno,
//        b.Beamlenght,
//        b.zunit,
//        @Semantics.quantity.unitOfMeasure : 'zunit'
//        b.Grooswt,
//        @Semantics.quantity.unitOfMeasure : 'zunit'
//        b.Tarewt,
//        @Semantics.quantity.unitOfMeasure : 'zunit'
//        b.Netwt,
//        b.Rpm,
//        b.Warper,
//        b.Zcount,
        c.Zptotends as Toatlends,
        d.warpcount1,
        a.SateDate,
        F.ManufacturingOrder,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        F.ActualDeliveredQuantity,
        F.ProductionUnit,
        F.ManufacturingOrderType,
        case when e.setnumber is not null or e.setnumber <> '' or e.setnumber is not initial
         then 'Approved' else '' end as SetApproved

    
}  
   where  d.warpcount1  is not initial and d.warpcount1 <> '0' and F.ManufacturingOrderType = 'SWP1'
   group by 
        a.ZmcNo,
        a.ZfsetNo,
        a.UnitField,
        a.Zlength,
        a.material,
        c.Zptotends ,
        d.warpcount1,
        a.SateDate,
        e.setnumber,
         F.ManufacturingOrder,
        F.ActualDeliveredQuantity,
         F.ProductionUnit,
         F.ManufacturingOrderType
