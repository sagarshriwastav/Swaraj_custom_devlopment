@AbapCatalog.sqlViewName: 'YSHRINKAGELOM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Shrinkage loom Entry Report'
define view ZPP_SHRINKAGE_LOOM_ENTRY_REP  
   with parameters
    p_fromdate : abap.char( 10 ),
    p_todate   : abap.char( 10 )
    as select from zsubcon_head as a 
      left outer join ZPP_SHRINKAGE_LOOM_BEAMLEN_101 as b on ( b.Batch = a.dyebeam  and b.Supplier = a.party )
     left outer join  ZPP_SHRINKAGE_LOOM_GREYREC_541 as C on ( C.Batch  = a.dyebeam   )
     left outer join I_OperationalAcctgDocItem as d on ( d.PostingDate  =  a.date1 ) 
   // left outer join ZMM_ROLL_NO_CDS as d on ( d.date1  =  a.date1 ) 
     left outer join  zsubcon_item_data   as e on ( e.Dyebeam = a.dyebeam and e.Party  = a.party )
     left outer join ZMM_SHRINK_REPORT_CDS as F on  ( F.Dyebeam = a.dyebeam  and F.Party = a.party    )  //zsubcon_item
     left outer join ZMM_MIGO_QTY_SUM as G on ( G.PurchaseOrder = b.PurchaseOrder  )
     
  
{
   key a.party,
   key a.dyebeam,
       a.partyname,
        a.partybeam,
       a.beampipe ,
       cast( 'M' as abap.unit( 3 ) )  as UnitFieldMTR  ,
       b.Beamlength as Beamlength ,
    //   C.GreyReceiveMtr  as GreyReceiveMtr,
      G.qty_migo  as  GreyReceiveMtr,
      C.qtylength,
       a.date1 as Posting_Date,
       a.date2  as Closing_Date,
       a.startingdate as posting_date1,
       a.loom as Loom_No,
       a.grsortno as Grey_Sort,
       a.t_ends as Total_Ends,
       a.shade as Shade,
       a.pick as Pick,
       a.reed_spac as Reed_Space,
       a.reed as Reed,
       a.dent as Dent,
       d.FiscalYear ,
       F.Est_FabricToReceived  as est_fabrictoreceived  ,
       e.remarks,
       F.Mtr   as Mtr
//       G.qty_migo
      
       
       
      
}  
  where a.date2 >= $parameters.p_fromdate 
  and   a.date2 <= $parameters.p_todate  
  
  
  group by
    a.party,
    a.dyebeam,
    a.partyname,
    a.partybeam,
    a.beampipe ,
    b.Beamlength,
    C.GreyReceiveMtr,
    a.date1,
    a.date2,
    a.loom,
    a.grsortno,
    a.t_ends,
    a.shade,
    a.pick,
    a.reed_spac,
    a.reed,
    a.dent, 
    d.FiscalYear,
    F.Est_FabricToReceived,
    e.remarks,
    F.Mtr,
    C.qtylength,
    a.startingdate,
    G.qty_migo
    
     
      
 
    
    
    
