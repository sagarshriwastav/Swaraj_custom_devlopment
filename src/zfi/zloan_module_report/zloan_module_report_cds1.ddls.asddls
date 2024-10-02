@AbapCatalog.sqlViewName: 'YLOANCDS2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loan Moduel Report'
define view ZLOAN_MODULE_REPORT_CDS1
with parameters 
                p_posting:abap.dats
                as select from ZLOAN_MODULE_REPORT_CDS( p_posting: $parameters.p_posting )
{
    key Companycode,
    key Glcode,
    Loannoid,
    GlName,
    Repaymentfrequency,
    Sentiondate,
    Moratoriumperiod,
    Numberofinstalments,
    Totalloanamount,
    DisTransactionCurrency,
    @Semantics.amount.currencyCode: 'DisTransactionCurrency'
    TotalDisbursed,
    lastInstalmentDate,
    LastTransactionCurrency,
    @Semantics.amount.currencyCode: 'LastTransactionCurrency'
    lastInstalmentAmount,
    InterestAmount,
    cast( OutsatndingLoanBlncAftLastIn as abap.dec( 13, 2 ) )  as OutsatndingLoanBlncAftLastIn,
    NextInstallmentDate,
    NextInstallmentAmount,
    cast( OutsatndingLoanBalnceAsOnDate as abap.dec( 13, 2 ) )  as OutsatndingLoanBalnceAsOnDate,
    Interestrate,
    fltp_to_dec(InterestAmountCalculated as abap.dec( 13, 2 ) )  as InterestAmountCalculated,
    InterestAmountActual,
    Veriance_Deffernce
}
