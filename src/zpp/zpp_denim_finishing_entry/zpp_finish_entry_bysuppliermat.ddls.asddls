@AbapCatalog.sqlViewName: 'YBATCHBYSUPP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Denim Finish Entry'
define view ZPP_FINISH_ENTRY_BYSUPPLIERMAT as select from I_Batch
{
    key Material,
    key Batch ,
        BatchBySupplier
}  

 group by 
        Material,
        Batch ,
        BatchBySupplier
