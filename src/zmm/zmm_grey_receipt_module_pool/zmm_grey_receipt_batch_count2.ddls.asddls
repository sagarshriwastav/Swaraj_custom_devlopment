@AbapCatalog.sqlViewName: 'YABAC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Grey Receipt Batch Count'
define view ZMM_GREY_RECEIPT_BATCH_COUNT2 as select from ZMM_GREY_RECEIPT_BATCH_COUNT as a 
left outer join zpp_alphabet_ta1 as b on ( b.sno = a.PcsNo)
{
    key a.Batch,
       b.alphabet
}
