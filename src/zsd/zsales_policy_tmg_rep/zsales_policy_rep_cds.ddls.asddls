@AbapCatalog.sqlViewName: 'YSALESPOLICYCDS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Sales Policy Report Cds'
define view ZSALES_POLICY_REP_CDS as select from zsales_polic_tab as a
    left outer join ZSALES_POLICY_CDS as b on ( b.plant = a.plant )
{
    key a.plant,
    key a.policyno,
    key a.nameofpolicyprovider,
    key a.policystartdate,
    key a.policycoverageperiod,
    key a.policyrenweldate,
        a.policycoverageamount,
   //     b.TransactionCurrency,

         cast( 'INR' as abap.cuky( 5 ) ) as TransactionCurrency,
        sum(b.invoicevalue) as invoicevalue,   
       ( (a.policycoverageamount ) - cast(sum(b.invoicevalue) as abap.dec( 13, 2 ))  ) as RemainingVakueInPolicy
       
} group by a.plant,
           a.policyno,
           a.nameofpolicyprovider,
           a.policystartdate,
           a.policycoverageperiod,
           a.policyrenweldate,
           a.policycoverageamount
       //    b.TransactionCurrency,
       //    b.invoicevalue

            
