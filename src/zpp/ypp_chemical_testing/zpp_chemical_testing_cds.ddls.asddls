@AbapCatalog.sqlViewName: 'YCHEMICLPARTY'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true 
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'pp chemical testing cds'
define view ZPP_CHEMICAL_TESTING_CDS as select from ZMM_MATERIAL_RECEIPT_CDS 

{     
     key ChmlPlant as Plant,
     key ChmlStorageLocation as StorageLocation,
     key PurchaseOrder,
         PurchaseOrderDate,
         Supplier,
         SupplierName,
         Material,
         ProductDescription as materialDescription,
         BR_NCM as HSN,
         gateno,
         vehical_no,
         ReferenceDocument as PartyBillNumber,
         DocumentDate as PartyBillDate,
         MaterialDocumentYear,
         PostingDate,
         CharcValueDescription,
         lotno,
         Batch,
         Testing,
         BaseUnit,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         RequestedQuantity as PRQuantity,
         @Semantics.quantity.unitOfMeasure: 'BaseUnit'
         OrderQuantity,
         MaterialBaseUnit,
         @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
         QuantityInBaseUnit,
         NoofBags
         
         
         
}
