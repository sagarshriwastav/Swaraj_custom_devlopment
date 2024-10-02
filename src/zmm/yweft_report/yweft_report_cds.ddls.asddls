@AbapCatalog.sqlViewName: 'YWEFT_REPORT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YWEFT_REPORT_CDS'
define view YWEFT_REPORT_CDS as select from YWEFT_REPORT1  as a 
                  left outer join YWEFT_REPORT_CDSREMAINING1 as B on ( B.Component = a.Component 
                                                                     and B.PO =  a.PO 
                                                                     and B.PO_ITEM = a.PO_ITEM )
                  left outer join YLATEST_541_POSTING_DATE as c on ( c.Material = a.Component and c.Batch = a.Batch 
                                                                    and c.Plant = a.Plant  )                                                   
{
    key a.PO,
    a.PO_ITEM,
    a.Grey_Fabric,
    a.Plant,
    a.PlannedGreyQuantity,
    a.SO,
    a.SO_Item,
    a.Component,
    cast( 'M' as abap.unit( 3 ) ) as ZMtrUnit,
    a.WeftRequiredQty,
    a.Party_Code,
    a.Batch,
    a.SupplierName,
    a.ProductDescription,
     ( cast( case when a.QuantityInEntryUnit541 is not null then a.QuantityInEntryUnit541  else 0 end as abap.dec( 13, 3 ) ) ) -
     ( cast( case when a.QuantityInEntryUnit542 is not null then a.QuantityInEntryUnit542 else 0 end as abap.dec( 13, 3 ) ) )
     as  WeftTransferredQty ,
     
    ( cast( case when a.WeftRequiredQty is not null then a.WeftRequiredQty  else 0 end as abap.dec( 13, 3 ) ) ) -
    ( cast( case when WeftTransferredQty is not null then WeftTransferredQty  else 0 end as abap.dec( 13, 3 ) ) ) 
          as  QTY_REMAINING ,
    a.MaterialBaseUnit,
    a.ClfnObjectInternalID,
    a.lotno,
    a.milno,
    a.CharcValueDescription,
    c.LatestDate as PostingDate
   
    
} 
