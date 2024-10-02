@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'PR PRINTOUT DETAILS'
@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
@ObjectModel.representativeKey: 'PurchaseRequisitionItem'

define view entity zmm_gr

as select from I_PurchaseRequisitionItemAPI01 as I_PurchaseRequisitionItemAPI01
association[0..*] to I_ProductValuationBasic as _I_ProductValuationBasic on _I_ProductValuationBasic.Product = I_PurchaseRequisitionItemAPI01.Material
association[0..*] to I_ProductDescription as _I_ProductDescription on _I_ProductDescription.Product = I_PurchaseRequisitionItemAPI01.Material
association[0..*] to I_StockQuantityCurrentValue_2 as _I_StockQuantityCurrentValue_2 on _I_StockQuantityCurrentValue_2.Product = I_PurchaseRequisitionItemAPI01.Material
association[0..1] to I_PurchaseRequisitionAPI01 as _I_PurchaseRequisitionAPI01 on _I_PurchaseRequisitionAPI01.PurchaseRequisition = I_PurchaseRequisitionItemAPI01.PurchaseRequisition

{
@EndUserText.label: 'Purchase Requisition'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_PurchaseRequisitionItemAPI01.PurchaseRequisition as PurchaseRequisition,

@EndUserText.label: 'Requisn. item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_PurchaseRequisitionItemAPI01.PurchaseRequisitionItem as PurchaseRequisitionItem,

@EndUserText.label: 'Requisitioner'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null

@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseRequisitionItemAPI01.RequisitionerName as RequisitionerName,

@EndUserText.label: 'Req. Tracking Number'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseRequisitionItemAPI01.RequirementTracking as RequirementTracking,

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
I_PurchaseRequisitionItemAPI01.PurchaseRequisitionType as PurchaseRequisitionType,

@EndUserText.label: 'Requisition Date'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseRequisitionItemAPI01.CreationDate as CreationDate,

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
I_PurchaseRequisitionItemAPI01.Plant as Plant,

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
I_PurchaseRequisitionItemAPI01.Material as Material,

@EndUserText.label: 'Product Description'
@Semantics.text: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_ProductDescription.ProductDescription as ProductDescription,

@EndUserText.label: 'Quantity requested'
@Semantics.quantity.unitOfMeasure: 'BaseUnit'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseRequisitionItemAPI01.RequestedQuantity as RequestedQuantity,

@EndUserText.label: 'Unit of Measure'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseRequisitionItemAPI01.BaseUnit as BaseUnit,

@EndUserText.label: 'Moving price'
@Semantics.amount.currencyCode: 'Currency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_ProductValuationBasic.MovingAveragePrice as MovingAveragePrice,

@EndUserText.label: 'Valuation Price'
@Semantics.amount.currencyCode: 'PurReqnItemCurrency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseRequisitionItemAPI01.PurchaseRequisitionPrice as PurchaseRequisitionPrice,

@EndUserText.label: 'Standard price'
@Semantics.amount.currencyCode: 'Currency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_ProductValuationBasic.StandardPrice as StandardPrice,

@EndUserText.label: 'Currency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseRequisitionItemAPI01.PurReqnItemCurrency as PurReqnItemCurrency,

@EndUserText.label: 'Currency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null

@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_ProductValuationBasic.Currency as Currency,

@EndUserText.label: 'Stock Quantity'
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
_I_StockQuantityCurrentValue_2( P_DisplayCurrency: 'INR' ).MatlWrhsStkQtyInMatlBaseUnit as MatlWrhsStkQtyInMatlBaseUnit,

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
_I_StockQuantityCurrentValue_2( P_DisplayCurrency: 'INR' ).MaterialBaseUnit as MaterialBaseUnit,

@EndUserText.label: 'Display Currency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_StockQuantityCurrentValue_2( P_DisplayCurrency: 'INR' ).DisplayCurrency as DisplayCurrency,

@EndUserText.label: 'Stock Value CC Currency'
@Semantics.amount.currencyCode: 'Currency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: #SUM
_I_StockQuantityCurrentValue_2( P_DisplayCurrency: 'INR' ).StockValueInCCCrcy as StockValueInCCCrcy,

@EndUserText.label: 'Currency'
@ObjectModel.foreignKey.association: '_Currency'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_StockQuantityCurrentValue_2( P_DisplayCurrency: 'INR' ).Currency as Currency_1,

@EndUserText.label: 'Fixed Vendor'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_PurchaseRequisitionItemAPI01.FixedSupplier as FixedSupplier,

@EndUserText.label: 'PurReqn Description'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_PurchaseRequisitionAPI01.PurReqnDescription as PurReqnDescription,

@EndUserText.label: '_Currency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_StockQuantityCurrentValue_2( P_DisplayCurrency: 'INR' )._Currency as _Currency,

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
I_PurchaseRequisitionItemAPI01.Plant as /SAP/1_PLANT,

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
I_PurchaseRequisitionItemAPI01.PurchaseRequisitionType as /SAP/1_PURCHASEREQUISITIONTYPE,

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
I_PurchaseRequisitionItemAPI01.PurchasingGroup as /SAP/1_PURCHASINGGROUP,

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
I_PurchaseRequisitionItemAPI01.PurchasingOrganization as /SAP/1_PURCHASINGORGANIZATION
}


