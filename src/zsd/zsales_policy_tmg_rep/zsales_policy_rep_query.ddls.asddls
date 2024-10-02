//@AbapCatalog.sqlViewName: ''
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Sales Policy Report Query'
@AbapCatalog.sqlViewName : 'YY1_HIEBD38A5K'
@Analytics.query: true
@ObjectModel.modelingPattern: #ANALYTICAL_QUERY
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_QUERY ]
@EndUserText.label: 'Sales Policy Report Query'
define view ZSALES_POLICY_REP_QUERY as select from ZSALES_POLICY_REP_CUBE
{
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
key plant,
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
key policyno,
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
key nameofpolicyprovider,    
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
key policystartdate,
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
key policycoverageperiod,
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
key policyrenweldate,
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
policycoverageamount,
//@AnalyticsDetails.query.axis:#ROWS
@AnalyticsDetails.query.axis:#ROWS
 TransactionCurrency,
invoicevalue,
RemainingVakueInPolicy  as   RemainingValueInPolicy
}
