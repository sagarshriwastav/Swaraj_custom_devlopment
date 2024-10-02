@AbapCatalog.sqlViewName: 'YPUCHASEREGI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Material Receipt Report'
define view ZI_MaterialDocumentItem_REV101 as select from  I_GoodsMovementCube as a 
{
    key a.Batch,
    key a.PurchaseOrder,
    key a.PurchaseOrderItem,
    key a.Plant,
    key a.Material,
        cast( 'X' as abap.char( 1) ) as REVERS

}
  where 
     (  a.GoodsMovementType = '102' ) 
