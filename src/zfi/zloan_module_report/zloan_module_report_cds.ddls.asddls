@AbapCatalog.sqlViewName: 'YLOANCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loan Moduel Report'
define view ZLOAN_MODULE_REPORT_CDS
 with parameters 
                p_posting:abap.dats
                 as select from zloan_module_tab as a 
left outer join I_GLAccountText as b on ( b.GLAccount = a.glcode and b.Language = 'E' )
left outer join ZTotalDisbursed_CDS( p_posting:$parameters.p_posting  ) as c on ( c.GLAccount = a.glcode  and c.CompanyCode = a.companycode )
left outer join ZlastInstalmentDate_CDS( p_posting:$parameters.p_posting  ) as d on ( d.GLAccount = a.glcode  and d.CompanyCode = a.companycode )
{
    key a.companycode                          as Companycode,
    key a.glcode                               as Glcode,
        a.loannoid                             as Loannoid,
        b.GLAccountName                        as GlName,
        a.repaymentfrequency                   as Repaymentfrequency,
        a.sentiondate                          as Sentiondate,
        a.moratoriumperiod                     as Moratoriumperiod,
        a.numberofinstalments                  as Numberofinstalments,       
        a.totalloanamount                      as Totalloanamount,
        c.TransactionCurrency                  as DisTransactionCurrency,
        @Semantics.amount.currencyCode: 'DisTransactionCurrency'
        c.TotalDisbursed                       as TotalDisbursed,
        d.lastInstalmentDate                   as lastInstalmentDate,
        d.TransactionCurrency                  as LastTransactionCurrency,
        @Semantics.amount.currencyCode: 'LastTransactionCurrency'
        d.lastInstalmentAmount                 as lastInstalmentAmount,
        ''                                     as InterestAmount,
        c.TotalDisbursed                       as OutsatndingLoanBlncAftLastIn,
        ''                                     as NextInstallmentDate,
        a.installmentamount                    as NextInstallmentAmount,
        c.TotalDisbursed - a.installmentamount as OutsatndingLoanBalnceAsOnDate,        
        a.interestrate                         as Interestrate,
        cast(( c.TotalDisbursed  * a.interestrate ) as abap.fltp ) / cast( 366  as abap.fltp ) as InterestAmountCalculated,
        ''                                     as InterestAmountActual,
        ''                                     as Veriance_Deffernce
}
