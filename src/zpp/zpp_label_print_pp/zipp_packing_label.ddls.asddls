@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS view for Packing label'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZIPP_PACKING_LABEL as select from I_MaterialDocumentItem_2 as I_MaterialDocumentItem 
association[0..1] to I_ManufacturingOrderItem as _I_ManufacturingOrderItem on _I_ManufacturingOrderItem.ManufacturingOrder = I_MaterialDocumentItem.OrderID
and _I_ManufacturingOrderItem.ManufacturingOrderItem = I_MaterialDocumentItem.MaterialDocumentItem 
association[0..1] to I_Product as _I_PRODUCT on _I_PRODUCT.Product = I_MaterialDocumentItem.Material
and _I_PRODUCT.ProductOldID = I_MaterialDocumentItem.DeliveryDocumentItem  
{
@EndUserText.label: 'Material Document Year'
@ObjectModel.foreignKey.association: '_MaterialDocumentYear'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_MaterialDocumentItem.MaterialDocumentYear as MaterialDocumentYear,

@EndUserText.label: 'Material Document'
@ObjectModel.foreignKey.association: '_MaterialDocumentHeader'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_MaterialDocumentItem.MaterialDocument as MaterialDocument,

@EndUserText.label: 'Material Document Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_MaterialDocumentItem.MaterialDocumentItem as MaterialDocumentItem,

@EndUserText.label: 'Material'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.Material as Material,

@EndUserText.label: 'Plant'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.Plant as Plant,

@EndUserText.label: 'Batch'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.Batch as Batch,

@EndUserText.label: 'Storage Location'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.StorageLocation as StorageLocation,

@EndUserText.label: 'Sales Order'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.SalesOrder as SalesOrder,

@EndUserText.label: 'Sales Order Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.SalesOrderItem as SalesOrderItem,

@EndUserText.label: 'Quantity'
@Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: #SUM
I_MaterialDocumentItem.QuantityInBaseUnit as QuantityInBaseUnit,

@EndUserText.label: 'Base Unit of Measure'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.MaterialBaseUnit as MaterialBaseUnit,

@EndUserText.label: 'Posting Date'
@Semantics.businessDate.at: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.PostingDate as PostingDate,

@EndUserText.label: 'Document Date'
@Semantics.businessDate.at: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.DocumentDate as DocumentDate,

@EndUserText.label: 'Order'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.OrderID as OrderID,

@EndUserText.label: 'Order Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.OrderItem as OrderItem,

@EndUserText.label: 'Reversed Doc Year'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.ReversedMaterialDocumentYear as ReversedMaterialDocumentYear,

@EndUserText.label: 'Batch'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_ManufacturingOrderItem.Batch as Batch_1,

@EndUserText.label: 'Reversed Mat Doc'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.ReversedMaterialDocument as ReversedMaterialDocument,

@EndUserText.label: 'Text'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.MaterialDocumentItemText as MaterialDocumentItemText,

@EndUserText.label: '_MaterialDocumentYear'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem._MaterialDocumentYear as _MaterialDocumentYear,

@EndUserText.label: '_MaterialDocumentHeader'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem._MaterialDocumentHeader as _MaterialDocumentHeader,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.GoodsMovementType as /SAP/1_GOODSMOVEMENTTYPE,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.IssuingOrReceivingPlant as /SAP/1_ISSUINGORRECEIVINGPLANT,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.IssuingOrReceivingStorageLoc as /SAP/1_ISSUING_YME2N2_ORAGELOC,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.Plant as /SAP/1_PLANT,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.StorageLocation as /SAP/1_STORAGELOCATION,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem._BPStockOwner as /SAP/1__BPSTOCKOWNER,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem._Customer as /SAP/1__CUSTOMER,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem._CustomerCompanyByPlant as /SAP/1__CUSTOMERCOMPANYBYPLANT,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem._IssuingOrReceivingStorageLoc as /SAP/1__ISSUIN_CBBW5Q_ORAGELOC,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem._StorageLocation as /SAP/1__STORAGELOCATION,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem._Supplier as /SAP/1__SUPPLIER,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem._SupplierCompanyByPlant as /SAP/1__SUPPLIERCOMPANYBYPLANT,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.StockOwner as /SAP/1_STOCKOWNER,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.Customer as /SAP/1_CUSTOMER,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentItem.Supplier as /SAP/1_SUPPLIER
,
_I_PRODUCT.ProductOldID as OLDMATERIAL
}
where I_MaterialDocumentItem.ReversedMaterialDocument = ' ' and I_MaterialDocumentItem.GoodsMovementType = '101' and I_MaterialDocumentItem.OrderID  <>  ' '

    
