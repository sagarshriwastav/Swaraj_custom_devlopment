@AbapCatalog.sqlViewName: 'YSHRIKANGE'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Shrinkage Loom Entry  Report'
define view zsubcon_item_data as select from zsubcon_item as a // ZSUBCON_tabl2 as a
{
    key a.party as Party,
    key a.dyebeam as Dyebeam,
    key a.grsortno ,
        sum(a.est_fabrictoreceived) as est_fabrictoreceived,
        a.remarks,
        sum(a.mtr)   as Mtr
} 
group by 
        a.party,
        a.dyebeam,
        a.grsortno,
        a.remarks
