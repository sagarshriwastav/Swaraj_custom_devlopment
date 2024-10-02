@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Material Document Data'
@Metadata.allowExtensions: true
@Search.searchable: false
@ObjectModel.representativeKey: 'MaterialDocument'

define view entity YMM_INTER_UNIT_CHALLAN

as select from I_MaterialDocumentHeader_2 as I_MaterialDocumentHeader_2
association[0..*] to I_MaterialDocumentItem_2 as _I_MaterialDocumentItem_2 on _I_MaterialDocumentItem_2.MaterialDocument = I_MaterialDocumentHeader_2.MaterialDocument
and _I_MaterialDocumentItem_2.Plant = I_MaterialDocumentHeader_2.Plant


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
key I_MaterialDocumentHeader_2.MaterialDocumentYear as MaterialDocumentYear,

@EndUserText.label: 'Material Document'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_MaterialDocumentHeader_2.MaterialDocument as MaterialDocument,

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
I_MaterialDocumentHeader_2.DocumentDate as DocumentDate_1,

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
I_MaterialDocumentHeader_2.PostingDate as PostingDate_1,


@EndUserText.label: 'Document Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.AccountingDocumentType as AccountingDocumentType,

@EndUserText.label: 'Trans. / Event Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.InventoryTransactionType as InventoryTransactionType,

@EndUserText.label: 'User Name'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.CreatedByUser as CreatedByUser,

@EndUserText.label: 'Entry Date'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.CreationDate as CreationDate,

@EndUserText.label: 'Time of Entry'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.CreationTime as CreationTime,

@EndUserText.label: 'Document Header Text'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.MaterialDocumentHeaderText as MaterialDocumentHeaderText,

@EndUserText.label: 'Delivery Document on Header'
@ObjectModel.foreignKey.association: '_DeliveryDocument'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.DeliveryDocument as DeliveryDocument_1,

@EndUserText.label: 'Reference'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.ReferenceDocument as ReferenceDocument,

@EndUserText.label: 'Bill of Lading'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.BillOfLading as BillOfLading,

@EndUserText.label: 'Plant'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.Plant as Plant,

@EndUserText.label: 'Storage Location'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.StorageLocation as StorageLocation,

@EndUserText.label: 'Transfer Plant'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.IssuingOrReceivingPlant as IssuingOrReceivingPlant_1,

@EndUserText.label: 'Receiving stor. loc.'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2.IssuingOrReceivingStorageLoc as IssuingOrReceivingStorageLo_1,

@EndUserText.label: 'Material Document Year'
@ObjectModel.foreignKey.association: '_MaterialDocumentYear_1'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.MaterialDocumentYear as MaterialDocumentYear_1,

@EndUserText.label: 'Storage Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.StorageType as StorageType,

@EndUserText.label: 'Storage Bin'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.StorageBin as StorageBin,

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
_I_MaterialDocumentItem_2.Batch as Batch,

@EndUserText.label: 'SLED/BBD'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ShelfLifeExpirationDate as ShelfLifeExpirationDate,

@EndUserText.label: 'Date of Manufacture'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ManufactureDate as ManufactureDate,

@EndUserText.label: 'Supplier'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.Supplier as Supplier,

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
_I_MaterialDocumentItem_2.SalesOrder as SalesOrder,

@EndUserText.label: 'Sales Order Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.SalesOrderItem as SalesOrderItem,

@EndUserText.label: 'Sales Order Schedule'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.SalesOrderScheduleLine as SalesOrderScheduleLine,

@EndUserText.label: 'WBS Element Special Stock'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.WBSElementInternalID as WBSElementInternalID,

@EndUserText.label: 'Customer'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.Customer as Customer,

@EndUserText.label: 'Special Stock Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.InventorySpecialStockType as InventorySpecialStockType,

@EndUserText.label: 'Stock Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.InventoryStockType as InventoryStockType,

@EndUserText.label: 'Additional Supplier for Special Stock'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.StockOwner as StockOwner,



@EndUserText.label: 'Movement Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.GoodsMovementType as GoodsMovementType,

@EndUserText.label: 'Debit/Credit ind'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.DebitCreditCode as DebitCreditCode,

@EndUserText.label: 'Posting Control Stock Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.InventoryUsabilityCode as InventoryUsabilityCode,

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
_I_MaterialDocumentItem_2.QuantityInBaseUnit as QuantityInBaseUnit,

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
_I_MaterialDocumentItem_2.MaterialBaseUnit as MaterialBaseUnit,

@EndUserText.label: 'Qty in unit of entry'
@Semantics.quantity.unitOfMeasure: 'EntryUnit'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: #SUM
_I_MaterialDocumentItem_2.QuantityInEntryUnit as QuantityInEntryUnit,

@EndUserText.label: 'Unit of Entry'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.EntryUnit as EntryUnit,

@EndUserText.label: 'Posting Date'
@Semantics.businessDate.at: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.PostingDate as PostingDate,

@EndUserText.label: 'Document Date'
@Semantics.businessDate.at: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.DocumentDate as DocumentDate,

@EndUserText.label: 'Amt.in Loc.Cur.'
@Semantics.amount.currencyCode: 'CompanyCodeCurrency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: #SUM
_I_MaterialDocumentItem_2.TotalGoodsMvtAmtInCCCrcy as TotalGoodsMvtAmtInCCCrcy,

@EndUserText.label: 'Company Code Currency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.CompanyCodeCurrency as CompanyCodeCurrency,

@EndUserText.label: 'Valuation Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.InventoryValuationType as InventoryValuationType,

@EndUserText.label: 'Res Final Issue'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ReservationIsFinallyIssued as ReservationIsFinallyIssued,

@EndUserText.label: 'Purchase Order'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.PurchaseOrder as PurchaseOrder,

@EndUserText.label: 'Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.PurchaseOrderItem as PurchaseOrderItem,

@EndUserText.label: 'Network'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ProjectNetwork as ProjectNetwork,

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
_I_MaterialDocumentItem_2.OrderID as OrderID,

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
_I_MaterialDocumentItem_2.OrderItem as OrderItem,

@EndUserText.label: 'Opertn task list no.'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.MaintOrderRoutingNumber as MaintOrderRoutingNumber,

@EndUserText.label: 'Counter'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.MaintOrderOperationCounter as MaintOrderOperationCounter,

@EndUserText.label: 'Reservation'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.Reservation as Reservation,

@EndUserText.label: 'Reservation Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ReservationItem as ReservationItem,

@EndUserText.label: 'Delivery'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.DeliveryDocument as DeliveryDocument,

@EndUserText.label: 'Delivery Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.DeliveryDocumentItem as DeliveryDocumentItem,

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
_I_MaterialDocumentItem_2.ReversedMaterialDocumentYear as ReversedMaterialDocumentYear,

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
_I_MaterialDocumentItem_2.ReversedMaterialDocument as ReversedMaterialDocument,

@EndUserText.label: 'Reversed Doc Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ReversedMaterialDocumentItem as ReversedMaterialDocumentItem,

@EndUserText.label: 'RevGR despite IR'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.RvslOfGoodsReceiptIsAllowed as RvslOfGoodsReceiptIsAllowed,

@EndUserText.label: 'Goods Recipient'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.GoodsRecipientName as GoodsRecipientName,

@EndUserText.label: 'Unloading Point'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.UnloadingPointName as UnloadingPointName,

@EndUserText.label: 'Cost Center'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.CostCenter as CostCenter,

@EndUserText.label: 'G/L Account'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.GLAccount as GLAccount,

@EndUserText.label: 'Service Performer'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ServicePerformer as ServicePerformer,

@EndUserText.label: 'Personnel Number'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.PersonWorkAgreement as PersonWorkAgreement,

@EndUserText.label: 'Account Assignment Category'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.AccountAssignmentCategory as AccountAssignmentCategory,

@EndUserText.label: 'Work Item ID'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.WorkItem as WorkItem,

@EndUserText.label: 'Serv. Rendered Date'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ServicesRenderedDate as ServicesRenderedDate,

@EndUserText.label: 'Transfer Material'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.IssgOrRcvgMaterial as IssgOrRcvgMaterial,

@EndUserText.label: 'Transfer Plant'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.IssuingOrReceivingPlant as IssuingOrReceivingPlant,

@EndUserText.label: 'Receiving stor. loc.'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.IssuingOrReceivingStorageLoc as IssuingOrReceivingStorageLoc,

@EndUserText.label: 'Transfer Batch'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.IssgOrRcvgBatch as IssgOrRcvgBatch,

@EndUserText.label: 'Special Stock'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.IssgOrRcvgSpclStockInd as IssgOrRcvgSpclStockInd,

@EndUserText.label: 'Company Code'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.CompanyCode as CompanyCode,

@EndUserText.label: 'Business Area'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.BusinessArea as BusinessArea,

@EndUserText.label: 'Controlling Area'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ControllingArea as ControllingArea,

@EndUserText.label: 'Fiscal Year & Period from Posting date'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.FiscalYearPeriod as FiscalYearPeriod,

@EndUserText.label: 'Fiscal Year Variant'
@Semantics.fiscal.yearVariant: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.FiscalYearVariant as FiscalYearVariant,

@EndUserText.label: 'Reference Doc. Type'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.GoodsMovementRefDocType as GoodsMovementRefDocType,

@EndUserText.label: 'Delivery Completed'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.IsCompletelyDelivered as IsCompletelyDelivered,

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
_I_MaterialDocumentItem_2.MaterialDocumentItemText as MaterialDocumentItemText,

@EndUserText.label: 'Automat. Created'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.IsAutomaticallyCreated as IsAutomaticallyCreated,

@EndUserText.label: 'Receipt Indicator'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.GoodsReceiptType as GoodsReceiptType,

@EndUserText.label: 'Consumption'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.ConsumptionPosting as ConsumptionPosting,

@EndUserText.label: 'Original Line Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.MultiAcctAssgmtOriglMatlDocItm as MultiAcctAssgmtOriglMatlDocItm,

@EndUserText.label: 'Multi Acct Assgt'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2.MultipleAccountAssignmentCode as MultipleAccountAssignmentCode,

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
_I_MaterialDocumentItem_2.MaterialDocument as MaterialDocument_1,

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
_I_MaterialDocumentItem_2.MaterialDocumentItem as MaterialDocumentItem,

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
_I_MaterialDocumentItem_2.Material as Material,

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
_I_MaterialDocumentItem_2.Plant as Plant_1,

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
_I_MaterialDocumentItem_2.StorageLocation as StorageLocation_1,

@EndUserText.label: '_MaterialDocumentYear'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2._MaterialDocumentYear as _MaterialDocumentYear,

@EndUserText.label: '_DeliveryDocument'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2._DeliveryDocument as _DeliveryDocument,

@EndUserText.label: '_MaterialDocumentYear'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2._MaterialDocumentYear as _MaterialDocumentYear_1,

@EndUserText.label: '_MaterialDocumentHeader'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_MaterialDocumentItem_2._MaterialDocumentHeader as _MaterialDocumentHeader,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2._IssuingOrReceivingStorageLoc as /SAP/1__ISSUIN_CBBW5Q_ORAGELOC,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2._MaterialDocumentItem as /SAP/1__MATERIALDOCUMENTITEM,

@Analytics.hidden: true
@Consumption.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_MaterialDocumentHeader_2._StorageLocation as /SAP/1__STORAGELOCATION,

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
I_MaterialDocumentHeader_2.IssuingOrReceivingPlant as /SAP/1_ISSUINGORRECEIVINGPLANT,

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
I_MaterialDocumentHeader_2.IssuingOrReceivingStorageLoc as /SAP/1_ISSUING_YME2N2_ORAGELOC,

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
I_MaterialDocumentHeader_2.MaterialDocument as /SAP/1_MATERIALDOCUMENT,

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
I_MaterialDocumentHeader_2.MaterialDocumentYear as /SAP/1_MATERIALDOCUMENTYEAR,

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
I_MaterialDocumentHeader_2.Plant as /SAP/1_PLANT,

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
I_MaterialDocumentHeader_2.StorageLocation as /SAP/1_STORAGELOCATION
}
