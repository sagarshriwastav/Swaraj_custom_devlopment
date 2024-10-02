@AbapCatalog.sqlViewName: 'ZSTOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'stock cds'
define view ZSTOCK as select distinct from Ymat_STOCK1_SUM2
{
    key Material,
    key Plant,
    key StorageLocation,
            case when STock is not initial then 'X'
         else '' end as Stock
}

group by Material,
         Plant,
         StorageLocation,
         STock
