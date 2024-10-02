@AbapCatalog.sqlViewName: 'YSUMGREYSTOCK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Module Pool Screen'
define view ZMM_GREY_STOCK_CDS1 as select from ZMM_GREY_STOCK_CDS  as a 
        left outer join I_Supplier as b on ( b.Supplier = a.Supplier )
        inner join I_ProductDescription as c on ( c.Product = a.Material and c.Language = 'E')
         left outer join I_BatchDistinct as D on ( D.Batch = a.Batch and D.Material = a.Material  ) 
     
     left outer join ZMM_JOB_REC_REG_INTERNALID_1 as t on ( t.ClassType = '023' and t.ClfnObjectTable = 'MCH1'
                                                               and t.ClfnObjectInternalID = D.ClfnObjectInternalID )
                                                               
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as E on ( E.ClassType = '023' and E.ClfnObjectTable = 'MCH1'
                                                               and E.ClfnObjectInternalID = D.ClfnObjectInternalID
                                                               and E.CharcInternalID = t.Lotnumber )  // = '0000000807' ) // lotnumber
                                                              
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as F on ( F.ClassType = '023' and F.ClfnObjectTable = 'MCH1'
                                                               and F.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and F.CharcInternalID  = t.Milname )   //  = '0000000806' ) // millname
     left outer join ZI_ClfnCharcValueDesc_cds as h on ( h.mil = F.CharcValue and h.CharcInternalID =   t.Milname  
                                                and h.Language = 'E' )   
     left outer join I_StockQuantityCurrentValue_2( P_DisplayCurrency:'INR') as I on ( I.Batch = a.Batch and I.Product = a.Material 
                                                                                      and I.Supplier = a.Supplier and I.SDDocument = a.SDDocument 
                                                                                       and I.SDDocumentItem = a.SDDocumentItem 
                                                                                       and I.ValuationAreaType = '1' 
                                                                                       and ( I.InventorySpecialStockType = 'O' or I.InventorySpecialStockType = 'F' ) )   
     left outer join ZPP_YARN_TASTING_REP  as ActualCount on ( ActualCount.Batch = a.Batch and ActualCount.Parmeters = 'Actual Count' )                                                                                                                            
    {
    key a.Plant,
    key a.Material,
    key a.Batch,
    a.StorageLocation,
    a.Supplier,
    b.SupplierName,
    a.MaterialBaseUnit,
    a.SDDocument,
    a.SDDocumentItem,
    c.ProductDescription,
    E.CharcValue as lotno,
    F.CharcValue  as milno,
    h.CharcValueDescription as MillName,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    a.Stock,
    I.MatlWrhsStkQtyInMatlBaseUnit as BatchF4QtY,
    ActualCount.Zresult as  DENIER 
}   where  a.Stock > 0

group by 

    a.Plant,
    a.Material,
    a.Batch,
    a.StorageLocation,
    a.Supplier,
    b.SupplierName,
    a.MaterialBaseUnit,
    a.SDDocument,
    a.SDDocumentItem,
    c.ProductDescription,
    E.CharcValue ,
    F.CharcValue  ,
    h.CharcValueDescription ,
    a.Stock,
    I.MatlWrhsStkQtyInMatlBaseUnit ,
    ActualCount.Zresult 
