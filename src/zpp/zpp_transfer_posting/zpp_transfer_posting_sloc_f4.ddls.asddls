@AbapCatalog.sqlViewName: 'YSLOCLOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For StorageLoction F4'
define view ZPP_TRANSFER_POSTING_SLOC_F4 as select from I_StorageLocation
{
    key Plant,
    key StorageLocation, 
        StorageLocation as IssuingOrReceivingStorageLoc
}     where StorageLocation <> ''
 group by  
     Plant,
    StorageLocation
