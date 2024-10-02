@AbapCatalog.sqlViewName: 'YDYEING_ENDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZPP_DYEING_SORT_MASTER_C'
define view ZPP_DYEING_SORT_MASTER_C as select from ZPP_BCO_CDS
{
    key Ends,
        Dyeingsort,
        Weft1count1
}
