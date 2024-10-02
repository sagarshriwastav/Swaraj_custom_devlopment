@AbapCatalog.sqlViewName: 'YSALESCUBE'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Sales Policy Report Cube'

@EndUserText.label: 'Sales Policy Report Cube'
@Search.searchable: false
@Metadata.allowExtensions: true
@AbapCatalog.dataMaintenance: #DISPLAY_ONLY
@Analytics.dataCategory: #CUBE
@Analytics.internalName: #LOCAL
@ObjectModel.modelingPattern: #ANALYTICAL_CUBE
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_PROVIDER, #SQL_DATA_SOURCE, #CDS_MODELING_DATA_SOURCE ]
define view ZSALES_POLICY_REP_CUBE as select from ZSALES_POLICY_REP_CDS
{
@EndUserText.label: 'plant'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false   
@Consumption.filter.selectionType: null
@Aggregation.default: null    
key plant,   
@EndUserText.label: 'policy No'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key policyno,
@EndUserText.label: 'Name Of Policy Provider'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key nameofpolicyprovider,
@EndUserText.label: 'Policy Startdate'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key policystartdate,
@EndUserText.label: 'Policy Coverage Period'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
key policycoverageperiod,
@EndUserText.label: 'Policy Renwel Date'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null 
key policyrenweldate,
@EndUserText.label: 'Policy Coverage Amount'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
policycoverageamount,
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
invoicevalue,
@EndUserText.label: 'RemainingVakueInPolicy'
@ObjectModel.foreignKey.association: null
@ObjectModel.text.association: null
@ObjectModel.text.element: null
@Consumption.hidden: false
@Analytics.excludeFromRuntimeExtensibility: false
@Consumption.filter.mandatory: false
@Consumption.filter.multipleSelections: false
@Consumption.filter.selectionType: null
@Aggregation.default: null
RemainingVakueInPolicy
}
