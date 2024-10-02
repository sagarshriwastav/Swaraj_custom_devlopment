@AbapCatalog.sqlViewName: 'YSSCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YARAN STOCK AS ON DATE'
define view ZMM_YARAN_STOCK_ASON_DATE 

  with parameters
    p_fromdate : abap.dats,
    p_todate   : abap.dats  
        
  as select from  YPP_STOCK_CDS_501_2( p_fromdate:$parameters.p_fromdate , p_todate:$parameters.p_todate ) as  Master
 left outer  join  I_Customer as D on ( D.Customer = Master.Customer   )
 left outer join I_PurchaseOrderItemAPI01 as G on ( G.Material = Master.Material )       
                                         
   left outer join I_BatchDistinct                                          as b on ( b.Batch    = Master.Batch 
                                                                            and b.Material = Master.Material )
                                                                            
  left outer join ZMM_JOB_REC_REG_INTERNALID_1 as t on ( t.ClassType = '023' and t.ClfnObjectTable = 'MCH1'
                                                               and t.ClfnObjectInternalID = b.ClfnObjectInternalID ) 
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as c on 
                                                               ( c.ClassType = '023' and c.ClfnObjectTable = 'MCH1'
                                                               and c.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and c.CharcInternalID = t.Lotnumber ) // '0000000807' ) // lotnumber  
                                                               
  left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as h on ( h.ClassType = '023' and h.ClfnObjectTable = 'MCH1'
                                                               and h.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and h.CharcInternalID = t.Milname ) // '0000000806' ) // millname   
                                       
     left outer join I_ClfnObjectCharcValForKeyDate(P_KeyDate :$session.system_date  ) as e on ( e.ClassType = '023' and e.ClfnObjectTable = 'MCH1'
                                                               and e.ClfnObjectInternalID = t.ClfnObjectInternalID
                                                               and e.CharcInternalID = t.NoOFbags )  // = '0000000808' )      // no of bags  
                                                                                                    
                                                                
  left outer join ZI_ClfnCharcValueDesc_cds as i on ( i.mil = h.CharcValue and i.CharcInternalID =  t.Milname and // '0000000806' and 
                                                  i.Language = 'E' ) 
  left outer join I_ProductDescription_2 as DES on ( DES.Product = Master.Material and DES.Language = 'E' )                                                                                                              
  left outer join I_MfgOrderOperationComponent as p on ( p.Material = Master.Material and  p.Batch = Master.Batch)

{
  key Master.Material,
  key Master.Plant,    
  Master.GoodsMovementType,
  Master.StorageLocation,  
  Master.Batch , 
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  Master.Opening  as Opening,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  Master.Receipt                        as Receipt,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  Master.RevReceipt                     as RevReceipt,
  @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  Master.Closing  as Closing,
  Master.MaterialBaseUnit,
   Master.MaterialDocument,
   Master.Customer,
   i.CharcValueDescription as Milname,
   c.CharcValue  as Lotnumber,
    cast( e.CharcFromDecimalValue as abap.dec( 13, 3 ) ) as NoOFbags,
   D.CustomerName,
   DES.ProductDescription as SHORT_TEXT,
   p.BaseUnit,
   @Semantics.quantity.unitOfMeasure: 'BaseUnit'
   sum(p.RequiredQuantity) as RequiredQuantity
  
   
   
 
  
  
}

where 
  (
       Master.GoodsMovementType = '501' or Master.GoodsMovementType = '502'  and Master.Plant  = '1300' )
     
 group by 
  Master.Material,
  Master.Plant,
  Master.StorageLocation,
  Master.Batch ,
  Master.MaterialBaseUnit,
  Master.Opening,
  Master.Receipt,
  Master.RevReceipt,
  Master.Closing,
  Master.GoodsMovementType,
  Master.MaterialDocument,
  Master.Customer,
  i.CharcValueDescription,
  c.CharcValue,
  e.CharcFromDecimalValue,
  D.CustomerName,
  DES.ProductDescription,
  p.BaseUnit
  
   
   
 
  
 