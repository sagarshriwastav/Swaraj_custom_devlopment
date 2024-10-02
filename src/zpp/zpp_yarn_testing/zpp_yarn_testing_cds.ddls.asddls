@AbapCatalog.sqlViewName: 'YARNTESTING'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Yarn Testing Module Pool'
define view ZPP_YARN_TESTING_CDS as select from I_MaterialDocumentHeader_2 as a   
                   left outer join I_MaterialDocumentItem_2  as b on ( b.MaterialDocument = a.MaterialDocument 
                                                                    and b.MaterialDocumentYear = a.MaterialDocumentYear )
                   left outer join I_BatchDistinct as s on ( s.Batch = b.Batch and s.Material = b.Material )
       
               left outer join ZMM_JOB_REC_REG_INTERNALID_1 as t on ( t.ClassType = '023' and t.ClfnObjectTable = 'MCH1'
                                                               and t.ClfnObjectInternalID = s.ClfnObjectInternalID )   
                                                               
      left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as c on ( c.ClassType = '023' and c.ClfnObjectTable = 'MCH1'
                                                               and c.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and c.CharcInternalID = t.Lotnumber )  //  = '0000000807' ) // lotnumber
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as d on ( d.ClassType = '023' and d.ClfnObjectTable = 'MCH1'
                                                               and d.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and d.CharcInternalID  = t.Milname ) // = '0000000806' ) // millname  
                                                               
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as e on ( e.ClassType = '023' and e.ClfnObjectTable = 'MCH1'
                                                               and e.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and e.CharcInternalID = t.NoOFbags )  // = '0000000808' )      // no of bags  
                                                               
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as f on ( f.ClassType = '023' and f.ClfnObjectTable = 'MCH1'
                                                               and f.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and f.CharcInternalID = t.Noofcone  ) // '0000000809' )      // no of cones 
                                                               
    left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as g on ( g.ClassType = '023' and g.ClfnObjectTable = 'MCH1'
                                                               and g.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and g.CharcInternalID = '0000000821' )      //per cone wieght      
    left outer join ZI_ClfnCharcValueDesc_cds as h on ( h.mil = d.CharcValue and h.CharcInternalID = t.Milname  and // '0000000806' and 
                                                  h.Language = 'E' ) 
    
      left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as GA on ( GA.ClassType = '023' and GA.ClfnObjectTable = 'MCH1'
                                                               and GA.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and GA.CharcInternalID = t.SupplierCount )  
     
       left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as GB on ( GB.ClassType = '023' and GB.ClfnObjectTable = 'MCH1'
                                                               and GB.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and GB.CharcInternalID = t.SupplierCountCvPer )                                                                                                          
      
        left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as GC on ( GC.ClassType = '023' and GC.ClfnObjectTable = 'MCH1'
                                                               and GC.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and GC.CharcInternalID = t.SupplierCsp )  
       
        left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as GD on ( GD.ClassType = '023' and GD.ClfnObjectTable = 'MCH1'
                                                               and GD.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and GD.CharcInternalID = t.Suppliercvper )  
                                                                                                                                                                   
    left outer join ZPP_GET_ENTRY_NO as I on ( I.ebeln = b.PurchaseOrder and I.ebelp = b.PurchaseOrderItem 
                                                      and I.invoice = a.ReferenceDocument ) 
    inner join I_ProductDescription as j on ( j.Product = b.Material and j.Language = 'E' )  
    left outer join I_Supplier  as K on ( K.Supplier = b.Supplier )                                                                                              
                                                                                                                                                                     
{
   
    key a.ReferenceDocument,
    key a.MaterialDocument,
    key a.MaterialDocumentYear,
        a.PostingDate ,
        a.DocumentDate,
        b.MaterialDocumentItem,
        b.Supplier,
        K.SupplierName,
        b.Material,
        j.ProductDescription,
        b.Plant,
        b.StorageLocation,
        b.MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        b.QuantityInBaseUnit,
        b.Batch,
        b.SalesOrder,
        b.SalesOrderItem,
        s.ClfnObjectInternalID,
        c.CharcValue as lotno,
        d.CharcValue  as milno,
        cast( e.CharcFromDecimalValue as abap.dec( 13, 3 ) ) as NoofBags ,
        cast( f.CharcFromDecimalValue as abap.dec( 13, 3 ) )  as  NoOfCones,
//        cast( g.CharcFromDecimalValue as abap.dec( 13, 3 ) )  as  PerConesWeight,
        h.CharcValueDescription as MilName,
        I.gateno,
        I.vehical_no,
       cast( GA.CharcFromDecimalValue as abap.dec( 13, 0 ) ) as  SupplierCount ,
       cast( GB.CharcFromDecimalValue as abap.dec( 13, 2 ) ) as  SupplierCountCvPer ,
       cast( GC.CharcFromDecimalValue as abap.dec( 13, 3 ) ) as SupplierCsp ,
       cast( GD.CharcFromDecimalValue as abap.dec( 13, 2 ) ) as  Suppliercvper
        
        
        }   where ( b.GoodsMovementType = '101' or b.GoodsMovementType = '501' ) and b.Material like 'Y%'
                and a.AccountingDocumentType = 'WE' and b.GoodsMovementIsCancelled = ''
                
                
