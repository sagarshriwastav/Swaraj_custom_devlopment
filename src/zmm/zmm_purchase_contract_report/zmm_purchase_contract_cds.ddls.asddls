@AbapCatalog.sqlViewName: 'YCONNTRACT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Purchase Contract Report'
define view ZMM_PURCHASE_CONTRACT_CDS as select from I_PurchaseContractAPI01 as a 
             left outer join I_Supplier as SUP on (SUP.Supplier = a.Supplier )   
             left outer join I_PurchaseContractItemAPI01 as b on ( b.PurchaseContract = a.PurchaseContract 
                                                      and b.PurchaseContractItem = '00010' )                                  
             left outer join ZMM_PURCHASE_CONTRACT_CON_AMT3 as c on ( c.PurchaseContract = b.PurchaseContract ) 
             left outer join ZMM_PURCHASE_CONTRACT_BKD_QTY as d on ( d.PurchaseContract = b.PurchaseContract )  
             left outer join I_PurchaseOrderItemAPI01 as e on ( e.PurchaseContract = a.PurchaseContract 
                                                              and e.PurchasingDocumentDeletionCode <> 'L' )
             left outer join ZMM_PURCHASE_CONTRACT_GRN_QTY as g on ( g.PurchaseContract = a.PurchaseContract  )                                                                                                                                                                              
    
               

{
      key a.PurchaseContract,
          a.Supplier,
          SUP.SupplierName,
          a.ValidityStartDate,
          a.ValidityEndDate,
          b.TargetQuantity,
          c.PerPickRate,
          b.OrderPriceUnit,
          c.RollingCharges,              
          c.MendingCharges,
          c.JiletinCharges,
          d.TargetQuantity as BookedQty  ,
          sum(e.OrderQuantity) as OrederQty  ,
          //f.QuantityInBaseUnit , 
          g.MaterialBaseUnit,
          g.Grnqty   
          
}   where b.PurchasingContractDeletionCode <> 'L'
    group by 
          a.PurchaseContract,
          a.Supplier,
          SUP.SupplierName,
          a.ValidityStartDate,
          a.ValidityEndDate,
          b.TargetQuantity,
          b.OrderPriceUnit,
          c.PerPickRate,
          c.RollingCharges,              
          c.MendingCharges,
          c.JiletinCharges,
          d.TargetQuantity,
       //   f.QuantityInBaseUnit,
          g.MaterialBaseUnit,
          g.Grnqty
