@AbapCatalog.sqlViewName: 'ZSDQL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'still_dilver_quantity'
define view z_sdq 

as select from I_PurchaseOrderItemAPI01 as I_PurchaseOrderItemAPI01
association[0..*] to I_PurOrdScheduleLineAPI01 as _I_PurOrdScheduleLineAPI01 on _I_PurOrdScheduleLineAPI01.PurchaseOrderItem = I_PurchaseOrderItemAPI01.PurchaseOrderItem
and _I_PurOrdScheduleLineAPI01.PurchaseOrder = I_PurchaseOrderItemAPI01.PurchaseOrder
association[0..1] to I_PurchaseOrderAPI01 as _I_PurchaseOrderAPI01 on _I_PurchaseOrderAPI01.PurchaseOrder = I_PurchaseOrderItemAPI01.PurchaseOrder

{
@EndUserText.label: 'Purchase Order'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_PurchaseOrderItemAPI01.PurchaseOrder as PurchaseOrder,

@EndUserText.label: 'Purchase Order Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_PurchaseOrderItemAPI01.PurchaseOrderItem as PurchaseOrderItem,

@EndUserText.label: 'Material'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseOrderItemAPI01.Material as Material,

@EndUserText.label: 'Purchasing Document'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_PurOrdScheduleLineAPI01.PurchaseOrder as PurchaseOrder_1,

@EndUserText.label: 'Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_PurOrdScheduleLineAPI01.PurchaseOrderItem as PurchaseOrderItem_1,

@EndUserText.label: 'Scheduled Quantity'
@Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_PurOrdScheduleLineAPI01.ScheduleLineOrderQuantity as ScheduleLineOrderQuantity,

@EndUserText.label: 'Quantity Delivered'
@Semantics.quantity.unitOfMeasure: 'PurchaseOrderQuantityUnit'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_PurOrdScheduleLineAPI01.RoughGoodsReceiptQty as RoughGoodsReceiptQty,

@EndUserText.label: 'Order Unit'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_PurOrdScheduleLineAPI01.PurchaseOrderQuantityUnit as PurchaseOrderQuantityUnit,

@EndUserText.label: 'Purchase Order Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_PurchaseOrderAPI01.PurchaseOrderType as PurchaseOrderType,

@EndUserText.label: 'Deletion Indicator'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseOrderItemAPI01.PurchasingDocumentDeletionCode as PurchasingDocumentDeletionCode,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseOrderItemAPI01.Plant as /SAP/1_PLANT,

@Analytics.hidden: true
@Consumption.hidden: true
// @AbapCatalog.compiler.preferredAssociationOnElements: [ '/SAP/1_PURCHASEORDER' ]
// @ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
// @Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseOrderItemAPI01._PurchaseOrder as /SAP/1__PURCHASEORDER,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
// @Consumption.groupWithElement: null
 // @Consumption.valueHelp: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseOrderItemAPI01.PurchaseOrder as /SAP/1_PURCHASEORDER
}

where _I_PurchaseOrderAPI01.PurchaseOrderType <> 'ZRTN' 
