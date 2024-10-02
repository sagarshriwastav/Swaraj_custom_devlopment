@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR1_DATA'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YGSTR1_DATA

as select distinct from I_BillingDocument as I_BillingDocument
association[0..*] to I_BillingDocumentItem as _I_BillingDocumentItem on _I_BillingDocumentItem.BillingDocument = I_BillingDocument.BillingDocument
association[0..1] to I_BillingDocumentPartner as _I_BillingDocumentPartner on _I_BillingDocumentPartner.PartnerFunction = 'RE'
and _I_BillingDocumentPartner.BillingDocument = I_BillingDocument.BillingDocument
association[0..1] to I_BillingDocumentPartner as _I_BillingDocumentPartner_1 on _I_BillingDocumentPartner_1.PartnerFunction = 'WE'
and _I_BillingDocumentPartner_1.BillingDocument = I_BillingDocument.BillingDocument
association[0..1] to I_BillingDocument as _I_BillingDocument on _I_BillingDocument.BillingDocument = I_BillingDocument.BillingDocument
and _I_BillingDocument.BillingDocumentIsCancelled = ''
association[0..1] to I_BillingDocumentPartner as _I_BillingDocumentPartner_2 on _I_BillingDocumentPartner_2.PartnerFunction = 'ZT'
and _I_BillingDocumentPartner_2.BillingDocument = I_BillingDocument.BillingDocument
association[0..1] to I_BillingDocumentPartner as _I_BillingDocumentPartner_3 on _I_BillingDocumentPartner_3.PartnerFunction = 'SP'
and _I_BillingDocumentPartner_3.BillingDocument = I_BillingDocument.BillingDocument
association[0..1] to I_BillingDocumentBasic as _I_BillingDocumentBasic on _I_BillingDocumentBasic.BillingDocument = I_BillingDocument.BillingDocument
association[0..1] to I_BillingDocumentPartner as _I_BillingDocumentPartner_4 on _I_BillingDocumentPartner_4.PartnerFunction = 'ZA'
and _I_BillingDocumentPartner_4.BillingDocument = I_BillingDocument.BillingDocument

{
@EndUserText.label: 'Billing Document'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key I_BillingDocument.BillingDocument as BillingDocument,

@EndUserText.label: 'Billing Type'
@ObjectModel.foreignKey.association: '_BillingDocumentType'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.BillingDocumentType as BillingDocumentType,

@EndUserText.label: 'Created On'
//@Semantics.SystemDate.CreatedAt: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.CreationDate as CreationDate,

@EndUserText.label: 'Created By'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.CreatedByUser as CreatedByUser,

@EndUserText.label: 'Billing Date'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.BillingDocumentDate as BillingDocumentDate,

@EndUserText.label: 'Billing Document'
@ObjectModel.foreignKey.association: '_BillingDocument'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.BillingDocument as BillingDocument_1,

@EndUserText.label: 'Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: [ 'BillingDocumentItemText' ]
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.BillingDocumentItem as BillingDocumentItem,

@EndUserText.label: 'Material'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.Material as Material,

@EndUserText.label: 'Product'
@ObjectModel.foreignKey.association: '_Product'
@ObjectModel.text.association: '_ProductText'
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.Product as Product,

@EndUserText.label: 'Customer'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner.Customer as Customer,

@EndUserText.label: 'Address Number'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner.AddressID as AddressID,

@EndUserText.label: 'Item Description'
@Semantics.text: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.BillingDocumentItemText as BillingDocumentItemText,

@EndUserText.label: 'Partner Function'
@ObjectModel.foreignKey.association: '_PartnerFunction'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner.PartnerFunction as PartnerFunction,

@EndUserText.label: 'Name of Customer'
@Semantics.text: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._PayerParty.CustomerName as CustomerName,

@EndUserText.label: 'Customer Name'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._PayerParty.CustomerFullName as CustomerFullName,

@EndUserText.label: 'Partner Function'
@ObjectModel.foreignKey.association: '_PartnerFunction_1'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_1.PartnerFunction as PartnerFunction_1,

@EndUserText.label: 'Customer'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_1.Customer as Customer_1,

@EndUserText.label: 'Address Number'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_1.AddressID as AddressID_1,

@EndUserText.label: 'Plant'
@ObjectModel.foreignKey.association: '_Plant'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.Plant as Plant,

@EndUserText.label: 'Billed Quantity'
@Semantics.quantity.unitOfMeasure: 'BillingQuantityUnit'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.BillingQuantity as BillingQuantity,

@EndUserText.label: 'Sales Unit'
@ObjectModel.foreignKey.association: '_BillingQuantityUnit'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.BillingQuantityUnit as BillingQuantityUnit,

@EndUserText.label: 'Net Value'
@Semantics.amount.currencyCode: 'TransactionCurrency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.NetAmount as NetAmount,

@EndUserText.label: 'Tax Amount'
@Semantics.amount.currencyCode: 'TransactionCurrency'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.TaxAmount as TaxAmount,

@EndUserText.label: 'Reference Document'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.ReferenceSDDocument as ReferenceSDDocument,

@EndUserText.label: 'Reference Item'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.ReferenceSDDocumentItem as ReferenceSDDocumentItem,

@EndUserText.label: 'Sales Document'
@ObjectModel.foreignKey.association: '_SalesDocument'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.SalesDocument as SalesDocument,

@EndUserText.label: 'Sales Document Item'
@ObjectModel.foreignKey.association: '_SalesDocumentItem'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.SalesDocumentItem as SalesDocumentItem,

@EndUserText.label: 'Document Currency'
@ObjectModel.foreignKey.association: '_TransactionCurrency'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem.TransactionCurrency as TransactionCurrency,

@EndUserText.label: 'Transporter Partner Function'
@ObjectModel.foreignKey.association: '_PartnerFunction_2'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@onsumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_2.PartnerFunction as PartnerFunction_2,

@EndUserText.label: 'Transporter Code'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_2.Supplier as Supplier,

@EndUserText.label: 'Agent Code 1'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_3.Supplier as Supplier_1,

@EndUserText.label: 'Agent Partner Function 1'
@ObjectModel.foreignKey.association: '_PartnerFunction_3'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_3.PartnerFunction as PartnerFunction_3,

@EndUserText.label: 'Sales Organization'
@ObjectModel.foreignKey.association: '_SalesOrganization'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.SalesOrganization as SalesOrganization,

@EndUserText.label: 'Distribution Channel'
@ObjectModel.foreignKey.association: '_DistributionChannel'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.DistributionChannel as DistributionChannel,

@EndUserText.label: 'Division'
@ObjectModel.foreignKey.association: '_Division'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.Division as Division,

//@EndUserText.label: 'LR Date'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_LRDate_BDH as YY1_LRDate_BDH,
//
//@EndUserText.label: 'LR Number'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_LRNumber_BDH as YY1_LRNumber_BDH,
//
//@EndUserText.label: 'Remarks'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_Remarks_BDH as YY1_Remarks_BDH,
//
//@EndUserText.label: 'RFID Number'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_RFIDNumber_BDH as YY1_RFIDNumber_BDH,
//
//@EndUserText.label: 'Port State Code'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_PortStateCode_BDH as YY1_PortStateCode_BDH,
//
//@EndUserText.label: 'PreCarrier By/Transport Mode'
////@ObjectModel.foreignKey.association: '_YY1_PreCarrierByTransp_BDH'
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_PreCarrierByTransp_BDH as YY1_PreCarrierByTransp_BDH,
//
//@EndUserText.label: 'Place of Receipt by PreCarrier'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_PreCarrier_BDH as YY1_PreCarrier_BDH,
//
//@EndUserText.label: 'Port Pin Code'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_PortPinCode_BDH as YY1_PortPinCode_BDH,
//
//@EndUserText.label: 'Vessel/Flight No'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_VesselFlightNo_BDH as YY1_VesselFlightNo_BDH,
//
//@EndUserText.label: 'LC No.'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_LCNo_BDH as YY1_LCNo_BDH,
//
//@EndUserText.label: 'LC Date'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_LCDate_BDH as YY1_LCDate_BDH,
//
//@EndUserText.label: 'Line Seal Number'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_LineSealNumber_BDH as YY1_LineSealNumber_BDH,
//
//@EndUserText.label: 'EPCG/MIES No'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_EPCGMIESNo_BDH as YY1_EPCGMIESNo_BDH,
//
//@EndUserText.label: 'Vehicle Number'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_VehicleNumber_BDH as YY1_VehicleNumber_BDH,
//
//@EndUserText.label: 'Port of Discharge'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_PortofDischarge_BDH as YY1_PortofDischarge_BDH,
//
//@EndUserText.label: 'Remarks 1'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_Remakrs1_BDH as YY1_Remakrs1_BDH,
//
//@EndUserText.label: 'Port of Loading'
////@ObjectModel.foreignKey.association: '_YY1_PortofLoading_BDH'
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_PortofLoading_BDH as YY1_PortofLoading_BDH,
//
//@EndUserText.label: 'Container Number'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_VehicleContainerNu_BDH as YY1_VehicleContainerNu_BDH,

@EndUserText.label: 'Terms of Payment'
@ObjectModel.foreignKey.association: '_CustomerPaymentTerms'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.CustomerPaymentTerms as CustomerPaymentTerms,

@EndUserText.label: 'Clearing Status'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.InvoiceClearingStatus as InvoiceClearingStatus,

@EndUserText.label: 'Payment Method'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: [ 'PaymentMethodName' ]
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._PaymentMethod.PaymentMethod as PaymentMethod,

@EndUserText.label: 'Payment Method Name'
@Semantics.text: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._PaymentMethod.PaymentMethodName as PaymentMethodName,

//@EndUserText.label: 'EPCG Date'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic.YY1_EPCGDate_BDH as YY1_EPCGDate_BDH,

//@EndUserText.label: 'EPCG/MIES No'
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.hidden: false
//@Analytics.excludeFromRuntimeExtensibility: false
//@Consumption.filter.mandatory: false
//@Consumption.filter.multipleSelections: false
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic._CancelledBillingDocumentBasic.YY1_EPCGMIESNo_BDH as YY1_EPCGMIESNo_BDH_1,

@EndUserText.label: 'Canceled Bill. Doc.'
@ObjectModel.foreignKey.association: '_CancelledBillingDocument'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.CancelledBillingDocument as CancelledBillingDocument,

@EndUserText.label: 'Canceled'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.BillingDocumentIsCancelled as BillingDocumentIsCancelled,

@EndUserText.label: 'Customer Group'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocument.CustomerGroup as CustomerGroup,

@EndUserText.label: 'Agent Partner Function 2'
@ObjectModel.foreignKey.association: '_PartnerFunction_4'
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_4.PartnerFunction as PartnerFunction_4,

@EndUserText.label: 'Agent Code 2'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_4.Supplier as Supplier_2,

@EndUserText.label: '_BillingDocumentType'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._BillingDocumentType as _BillingDocumentType,

@EndUserText.label: '_BillingDocument'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem._BillingDocument as _BillingDocument,

@EndUserText.label: '_Product'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem._Product as _Product,

@EndUserText.label: '_ProductText'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem._ProductText as _ProductText,

@EndUserText.label: '_PartnerFunction'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner._PartnerFunction as _PartnerFunction,

@EndUserText.label: '_PartnerFunction'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_1._PartnerFunction as _PartnerFunction_1,

@EndUserText.label: '_Plant'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem._Plant as _Plant,

@EndUserText.label: '_BillingQuantityUnit'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem._BillingQuantityUnit as _BillingQuantityUnit,

@EndUserText.label: '_SalesDocument'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem._SalesDocument as _SalesDocument,

@EndUserText.label: '_SalesDocumentItem'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem._SalesDocumentItem as _SalesDocumentItem,

@EndUserText.label: '_TransactionCurrency'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentItem._TransactionCurrency as _TransactionCurrency,

@EndUserText.label: '_PartnerFunction'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_2._PartnerFunction as _PartnerFunction_2,

@EndUserText.label: '_PartnerFunction'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_3._PartnerFunction as _PartnerFunction_3,

@EndUserText.label: '_SalesOrganization'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._SalesOrganization as _SalesOrganization,

@EndUserText.label: '_DistributionChannel'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._DistributionChannel as _DistributionChannel,

@EndUserText.label: '_Division'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._Division as _Division,

//@EndUserText.label: '_YY1_PreCarrierByTransp_BDH'
////@ObjectModel.association.type: null
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic._YY1_PreCarrierByTransp_BDH as _YY1_PreCarrierByTransp_BDH,
//
//@EndUserText.label: '_YY1_PortofLoading_BDH'
////@ObjectModel.association.type: null
//@ObjectModel.foreignKey.association: null
//@ObjectModel.text.association: null
//@ObjectModel.text.element: null
////@Consumption.groupWithElement: null
////@Consumption.valueHelp: null
//@Consumption.filter.selectionType: null
//@Aggregation.default: null
//_I_BillingDocumentBasic._YY1_PortofLoading_BDH as _YY1_PortofLoading_BDH,

@EndUserText.label: '_CustomerPaymentTerms'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._CustomerPaymentTerms as _CustomerPaymentTerms,

@EndUserText.label: '_CancelledBillingDocument'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument._CancelledBillingDocument as _CancelledBillingDocument,

@EndUserText.label: '_PartnerFunction'
//@ObjectModel.association.type: null
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.filter.selectionType: null
@Aggregation.default: null
_I_BillingDocumentPartner_4._PartnerFunction as _PartnerFunction_4,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.BillingDocumentType as /SAP/1_BILLINGDOCUMENTTYPE,

@Analytics.hidden: true
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
//@Consumption.groupWithElement: null
//@Consumption.valueHelp: null
@Consumption.hidden: true
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
I_BillingDocument.SalesOrganization as /SAP/1_SALESORGANIZATION
}
