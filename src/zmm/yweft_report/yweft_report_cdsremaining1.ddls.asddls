@AbapCatalog.sqlViewName: 'YWEFTREM2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Weft Report'
define view YWEFT_REPORT_CDSREMAINING1 as select from YWEFT_REPORT_CDSREMAINING
{
    key PO,
    PO_ITEM,
    Component,
    sum(WeftTransferredQty) as WeftTransferredQty
}    
  group by 
    PO,
    PO_ITEM,
    Component
