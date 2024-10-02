@AbapCatalog.sqlViewName: 'YPEICENUMBER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_GREY_RECEIPT_PEICE_FATCH'
define view ZPP_GREY_RECEIPT_PEICE_FATCH as select from zsubcon_item
{
    key partybeam as Partybeam,
    key loom as Loom,
    key dyebeam,
    length as Length,
    pick as Pick,
    netwt as netwt,
    rollno as Rollno,
    per_avg_mtr
    
    
}
