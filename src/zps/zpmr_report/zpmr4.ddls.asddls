@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PMR4 CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZPMR4
  as select from I_PurchaseOrderAPI01 as a inner join 
  I_Supplier as b on a.Supplier = b.Supplier 
  {
  
  
  a.CreationDate,
  a.PurchaseOrder,
  b.Supplier,
  b.SupplierName
  
  
  }
