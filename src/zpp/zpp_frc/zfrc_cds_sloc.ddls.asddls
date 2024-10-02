@AbapCatalog.sqlViewName: 'YSLOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Fents Regs Chindi Screen'
define view ZFRC_CDS_SLOC as select from I_MaterialStock_2
{
    key Plant,
    key StorageLocation
}  where Plant = '1200'   
group by  
       Plant,
       StorageLocation
