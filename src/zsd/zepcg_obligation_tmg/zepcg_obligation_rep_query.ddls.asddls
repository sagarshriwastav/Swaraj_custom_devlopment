//@AbapCatalog.sqlViewName: ''
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Cds For EPCG Obligation Report Query'
@AbapCatalog.sqlViewName : 'YY1_HIEBD38A5KPN'
@Analytics.query: true
@ObjectModel.modelingPattern: #ANALYTICAL_QUERY
@ObjectModel.supportedCapabilities: [ #ANALYTICAL_QUERY ]
@EndUserText.label: 'EPCG Obligation Report'
define view ZEPCG_OBLIGATION_REP_QUERY as select from ZEPCG_OBLIGATION_REP_CUBE
{ 
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
    key epcg_license_no,
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
    key valid_from,
@AnalyticsDetails.query.axis:#ROWS
@Consumption.filter :{ selectionType: #SINGLE, multipleSelections: false, mandatory: false }
    key valid_to,
//@AnalyticsDetails.query.axis:#ROWS
    export_obligation,
@AnalyticsDetails.query.axis:#ROWS
    TransactionCurrency,
//@AnalyticsDetails.query.axis:#ROWS 
    invoicevalue,
//@AnalyticsDetails.query.axis:#ROWS 
    BalanceValue 

}
