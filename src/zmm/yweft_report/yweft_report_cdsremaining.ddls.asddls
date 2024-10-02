@AbapCatalog.sqlViewName: 'YWEFTREM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Weft Report'
define view YWEFT_REPORT_CDSREMAINING as select from YWEFT_REPORT1
{
    key PO,
    PO_ITEM,
    Component,
    ( cast( case when QuantityInEntryUnit541 is not null then QuantityInEntryUnit541  else 0 end as abap.dec( 13, 3 ) ) ) -
     ( cast( case when QuantityInEntryUnit542 is not null then QuantityInEntryUnit542 else 0 end as abap.dec( 13, 3 ) ) )
      as  WeftTransferredQty ,
    QuantityInEntryUnit541,
    QuantityInEntryUnit542
}  

//group by  
//    PO,
//    PO_ITEM,
//    Component,
//    QuantityInEntryUnit541,
//    QuantityInEntryUnit542
