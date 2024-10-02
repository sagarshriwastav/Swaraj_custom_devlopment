@AbapCatalog.sqlViewName: 'YPPFINISH'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Finish Quality Screen Report'
define view ZPP_FINISH_ENTRY as select from I_ManufacturingOrderItem as a 
                   inner  join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
                  left outer join zpp_sortmaster as e on (  e.material = a.Material and e.plant = a.ProductionPlant )  
                  left outer  join ZPP_FINISH_ENTRY_GRQTY_2 as f on (f.OrderID = a.ManufacturingOrder )
                  left outer join zpp_sortmaster as g on ( g.pdcode = right(a.Material,7) and g.plant = a.ProductionPlant )
              //    left outer join ZDNM_DD as H on ( H.ZfsetNo = a.Batch )
                 left outer join ZPP_GREY_ENTRY_DATE_SETWISE2 as H on ( H.SetNumber = a.Batch and H.Plant = a.ProductionPlant )
                  left outer join zpp_approval_tab as I on ( I.setnumber = a.Batch and I.programno = '04' )
                  left outer join zpp_approval_tab as N on ( N.setnumber = a.Batch and N.programno = '08' ) 
                left outer join I_MfgOrderWithStatus  as t on ( t.ManufacturingOrder =  a.ManufacturingOrder )
{   
    key a.ManufacturingOrder,
    key a.Batch,
    key a.Material,
        a.ProductionPlant,
        a.ProductionUnit,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        a.MfgOrderPlannedTotalQty as TargetQty,
        a.StorageLocation,
        a.SalesOrder,
        a.SalesOrderItem,
        b.ProductDescription,
        case when e.dyeingshade = '' or e.dyeingshade is initial or e.dyeingshade is null then g.dyeingshade
        else e.dyeingshade end as dyeingshade ,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        f.GrQty,
        t.CreationDate,
        t.OrderIsTechnicallyCompleted,
        
        case when e.processroute = '' or e.processroute is initial or e.processroute is null then g.processroute 
        else e.processroute end as processroute,
     //   $session.system_date as SetDate,
        H.GreyDate as SetDate,
        case when I.setnumber is not null or I.setnumber <> '' or I.setnumber is not initial
        then 'Approved' else '' end as SetApproved,
        
         case when N.setnumber is not null or N.setnumber <> '' or N.setnumber is not initial
        then 'Approved' else '' end as TecoApproved
        
} where ( a.ManufacturingOrderType = 'SFF1' or a.ManufacturingOrderType = 'RT01'
          or a.ManufacturingOrderType = 'FDY1' or a.ManufacturingOrderType = 'FPH1'
          or a.ManufacturingOrderType = 'YDY1' ) and ( a.ProductionPlant = '1200' or a.ProductionPlant = '1400' )
