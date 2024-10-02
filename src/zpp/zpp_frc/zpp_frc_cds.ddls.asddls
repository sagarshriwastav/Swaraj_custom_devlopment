@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Fents Regs Chindi Screen'
define root view entity ZPP_FRC_CDS as select from I_MaterialStock_2

{
    
  key Material,
  key Plant,
  key Batch,
      StorageLocation,
      SDDocument,
      SDDocumentItem,
      MaterialBaseUnit,
      @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      sum(MatlWrhsStkQtyInMatlBaseUnit) as MatlWrhsStkQtyInMatlBaseUnit
      
}  // where InventoryStockType = '01'
 group by 
      Material,
      Plant,
      Batch,
      StorageLocation,
      SDDocument,
      SDDocumentItem,
      MaterialBaseUnit
