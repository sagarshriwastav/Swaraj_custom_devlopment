@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Dyeing Prod Entry'
define root view entity ZPP_DYEING_ENTRY_CDS as select from I_ManufacturingOrderItem as a 
                   inner  join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
                    left outer  join ZPP_FINISH_ENTRY_GRQTY_2 as f on (f.OrderID = a.ManufacturingOrder )
                    left outer join zpp_sortmaster as d on ( d.dyeingsort = a.Material)
                    left outer join ZDNM_DD as e on ( e.ZfsetNo = a.Batch )
                    left outer join zpp_approval_tab as C on ( C.setnumber = a.Batch and C.programno = '02' )
                    left outer join zpp_approval_tab as G on ( G.setnumber = a.Batch and G.programno = '07' )
             left outer join I_MfgOrderWithStatus  as t on ( t.ManufacturingOrder =  a.ManufacturingOrder )
{   
    key a.ManufacturingOrder,
    key a.Batch,
    key a.Material,
        a.ProductionPlant,
        a.ProductionUnit,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        a.MfgOrderPlannedTotalQty as TargetQty,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        f.GrQty,
        a.StorageLocation,
        b.ProductDescription,
        d.warpcount1,
        d.reedspace,
        t.CreationDate,
        t.OrderIsTechnicallyCompleted,
        e.SateDate as SetDate,
        case when C.setnumber is not null or C.setnumber <> '' or C.setnumber is not initial
         then 'Approved' else '' end as SetApproved,
         case when G.setnumber is not null or G.setnumber <> '' or G.setnumber is not initial
         then 'Approved' else '' end as TecoApproved
        
} where  a.ManufacturingOrderType = 'SDY1' and a.ProductionPlant = '1200' 
          and d.warpcount1  is not initial and d.warpcount1 <> '0'
    
     group by 
         a.ManufacturingOrder,
         a.Batch,
         a.Material,
        a.ProductionPlant,
        a.ProductionUnit,
        a.MfgOrderPlannedTotalQty,
        f.GrQty,
        a.StorageLocation,
        b.ProductDescription,
        d.warpcount1,
        d.reedspace,
        t.CreationDate,
        t.OrderIsTechnicallyCompleted,
        e.SateDate,
        C.setnumber,
        G.setnumber
