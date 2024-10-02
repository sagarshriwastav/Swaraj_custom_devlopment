@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_GREY_GRN_CDS'
define root view entity ZPP_GREY_GRN_CDS1 as select from I_ManufacturingOrderItem as a 
                   inner  join I_ProductDescription as b on ( b.Product = a.Material and b.Language = 'E' )
                   left outer  join ZPP_FINISH_ENTRY_GRQTY_2 as g on (g.OrderID = a.ManufacturingOrder )
                   inner join I_ManufacturingOrder   as h on ( h.ManufacturingOrder = a.ManufacturingOrder )
                   left outer join I_SalesDocument as i on ( i.SalesDocument = a.SalesOrder )
                   left outer join I_Customer as j on ( j.Customer = i.SoldToParty )
                   left outer join zpc_headermaster as K on ( K.zpno = h.YY1_MasterNumber_ORD )
                   left outer join I_Product  as l on ( l.Product = a.Material )
 //                   left outer join ZPP_SELVEDGE_F4_cds as M on ( M.Plant = a.ProductionPlant and M.Beamno = a.Batch )

{   
    key a.ManufacturingOrder,
    key a.Batch,
    key a.Material,
        a.ProductionPlant,
        a.ProductionUnit,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        a.MfgOrderPlannedTotalQty as TargetQty,
        a.StorageLocation,
        b.ProductDescription,
        @Semantics.quantity.unitOfMeasure: 'ProductionUnit'
        g.GrQty,
// a.MatlCompIsMarkedForDeletion,
        a.SalesOrder,
        a.SalesOrderItem,
        h.YY1_Pick_ORD,
        h.YY1_LoomNumber_ORD,
        h.YY1_PartyBeam_ORD,
        h.YY1_SetNo_ORD,
        j.CustomerName,
   //     K.ztowtpermtr,
   //     K.zpdytype,
        l.ProductOID
   //     M.Selvedge,
   //     M.remark
        
} where ( a.ManufacturingOrderType = 'SWV1' or a.ManufacturingOrderType = 'JWV1' 
         or a.ManufacturingOrderType = 'MWV1' or a.ManufacturingOrderType = 'MJW1') and
           ( a.ProductionPlant = '1300' or a.ProductionPlant = '2100' )
