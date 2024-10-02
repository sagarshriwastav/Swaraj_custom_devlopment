@AbapCatalog.sqlViewName: 'YGREYRECCDS1'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Program'
define view ZMM_GREY_RECEIPT_CDS1 as select from ZMM_GREY_RECEIPT_CDS
{
    key Batch,
    key PurchaseOrder,
    key PurchaseOrderItem,
    Material543,
    Material,
    BaseUnit,
    OrderQuantity,
    BeamLenght,
    SalesOrder,
    SalesOrderItem,
    Supplier,
    SupplierName,
    ProductDescription,
    loom,
    pick, 
    partybeam,
    FINISHROLL,
    SetDate,
    SetApproved,
    REVERS,
    dats_days_between( PostingDate, dats ) as Daygs
}
  
  where REVERS is null
