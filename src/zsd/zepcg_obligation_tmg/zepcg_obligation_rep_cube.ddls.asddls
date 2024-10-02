//@AbapCatalog.sqlViewName: ''
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Cds For EPCG Obligation Report Cube'

@EndUserText.label: 'Cds For EPCG Obligation Report Cube'
@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
@Analytics.dataCategory: #CUBE
@Analytics.internalName: #LOCAL
@ObjectModel.modelingPattern: #ANALYTICAL_CUBE
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_PROVIDER, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
define view entity ZEPCG_OBLIGATION_REP_CUBE as select from ZEPCG_OBLIGATION_REP_CDS
{   
@EndUserText.label: 'EPCG No'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
 key epcg_license_no,
@EndUserText.label: 'Valid From'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
    key valid_from,
 @EndUserText.label: 'Valid To'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
    key valid_to,
@EndUserText.label: 'Export Obligation'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
    export_obligation,
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
    TransactionCurrency,
@EndUserText.label: 'Invoice Value'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
@Semantics.amount.currencyCode: 'TransactionCurrency'
    invoicevalue,
 @EndUserText.label: 'Balance Obligation'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
@Semantics.amount.currencyCode: 'TransactionCurrency'
 BalanceValue
}
