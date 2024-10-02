@AbapCatalog.sqlViewName: 'YCDSREVSERSEDOC'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Reverse Document'
define view ZI_MaterialDocumentItem_REV as select from I_GoodsMovementCube as a 
{
    key a.Batch,
    key a.PurchaseOrder,
    key a.PurchaseOrderItem,
    key a.Plant,
    key a.Material,
    key a.Supplier, 
        cast( 'X' as abap.char( 1) ) as REVERS

}
  where 
     (  a.GoodsMovementType = '542' ) 
      and a.InventorySpecialStockType = 'F' 
