@AbapCatalog.sqlViewName: 'YNETWT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_GREY_RECEIPT_NETWT'
/*+[hideWarning] { "IDS" : [ "KEY_CHECK" ]  } */
define view ZMM_GREY_RECEIPT_NETWT as select from zsubcon_item
{
    party,
  rollno,
  cast( netwt as abap.dec(13,3) ) as netwt
    
}
