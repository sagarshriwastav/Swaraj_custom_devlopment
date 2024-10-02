@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZMM_WEFT_CONSUMPTION_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZWEFT_CONSUMPTION_CDS as select from I_MaterialDocumentItem_2 as a
     left outer join I_ProductDescription_2 as b on ( b.Product = a.Material and b.Language = 'E' )
     left outer join I_Supplier as c on ( c.Supplier = a.Supplier )
     left outer join I_MaterialDocumentHeader_2 as d on ( d.MaterialDocument = a.MaterialDocument
                                                         and d.MaterialDocumentYear = a.MaterialDocumentYear )
     left outer join I_PurchaseOrderItemAPI01 as e on ( e.PurchaseOrder = a.PurchaseOrder 
                                                       and e.PurchaseOrderItem = a.PurchaseOrderItem )
     left outer join I_Product as f on ( f.Product = a.Material )
     left outer join ZMM_WEFT_CONSUMPTION_QTY as g on ( g.MaterialDocument = a.MaterialDocument
                                                       and g.MaterialDocumentItem = a.MaterialDocumentItem )
     

{
    key a.Batch,
    key a.PurchaseOrder,
    key a.PurchaseOrderItem,
    key a.MaterialDocument,
    key a.MaterialDocumentItem,
        a.Material,
        a.Plant,
        a.PostingDate,
        a.DocumentDate,
        a.Supplier,
        d.MaterialDocumentHeaderText,
        b.ProductDescription,
        c.SupplierName,
        e.Material as material_e,
       // g.MaterialBaseUnit,
       cast( '' as abap.unit( 2 ) ) as MaterialBaseUnit,
        @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
        g.QuantityInBaseUnit,
  //      a.MaterialBaseUnit,
    //    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
      //  a.QuantityInBaseUnit as QuantityInBaseUnit
        a.CompanyCodeCurrency,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
        a.TotalGoodsMvtAmtInCCCrcy
      
        
} where a.GoodsMovementIsCancelled = ''
    and a.GoodsMovementType = '543'
    and f.IndustryStandardName = 'E'
    and a.InventorySpecialStockType = 'F'
    and a.Plant = '1200'
   // and a.TotalGoodsMvtAmtInCCCrcy is not initial

// group by a.Material,
//        a.Plant,
//        a.Batch,
//        a.PostingDate,
//        a.DocumentDate,
//        a.PurchaseOrder,
//        a.PurchaseOrderItem,
//        a.Supplier,
//        a.MaterialBaseUnit,
//       // a.QuantityInBaseUnit,
//        a.CompanyCodeCurrency,
//        a.TotalGoodsMvtAmtInCCCrcy,
//        b.ProductDescription,
//        c.SupplierName,
//        d.MaterialDocumentHeaderText,
//        e.Material
//
