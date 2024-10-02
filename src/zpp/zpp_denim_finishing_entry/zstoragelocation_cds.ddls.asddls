@AbapCatalog.sqlViewName: 'YSTLOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For StorageLocation'
define view ZStorageLocation_cds as select from I_StorageLocation
{
    key Plant,
    key StorageLocation,
        StorageLocationName
}   
     where Plant = '1200' or Plant = '1400'
     group by 
        Plant,
        StorageLocation,
        StorageLocationName
