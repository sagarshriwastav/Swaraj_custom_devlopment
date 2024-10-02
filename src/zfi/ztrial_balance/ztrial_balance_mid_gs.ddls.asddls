@AbapCatalog.sqlViewName: 'YTRAIL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Trail Balance'
define view ZTRIAL_BALANCE_MID_GS 
    with parameters 
    ZCompanyCode : abap.char( 4 ),
    ZFiscalYear   : abap.char( 4 )
   as select from  I_GLAccountLineItem as a
{
   key a.CompanyCode,
   key a.FiscalYear,
   key a.GLAccount ,
   key a.CompanyCodeCurrency,
       a.FiscalPeriod,
        case when a.FiscalPeriod = '001' then sum(a.AmountInCompanyCodeCurrency) else 0 end as APRIL,
       case when a.FiscalPeriod = '002' then sum(a.AmountInCompanyCodeCurrency) else 0 end as MAY,
       case when a.FiscalPeriod = '003' then sum(a.AmountInCompanyCodeCurrency) else 0 end as JUNE,
       case when a.FiscalPeriod = '004' then sum(a.AmountInCompanyCodeCurrency) else 0 end as JULY,
       case when a.FiscalPeriod = '005' then sum(a.AmountInCompanyCodeCurrency) else 0 end as AUGUST,
       case when a.FiscalPeriod = '006' then sum(a.AmountInCompanyCodeCurrency) else 0 end as SEPTEMBER,
       case when a.FiscalPeriod = '007' then sum(a.AmountInCompanyCodeCurrency) else 0 end as OCTOBER,
       case when a.FiscalPeriod = '008' then sum(a.AmountInCompanyCodeCurrency) else 0 end as NOVEMBER,
       case when a.FiscalPeriod = '009' then sum(a.AmountInCompanyCodeCurrency) else 0 end as DECEMBER,
       case when a.FiscalPeriod = '010' then sum(a.AmountInCompanyCodeCurrency) else 0 end as JANUARY,
       case when a.FiscalPeriod = '011' then sum(a.AmountInCompanyCodeCurrency) else 0 end as FEBRUARY,
       case when a.FiscalPeriod = '012' then sum(a.AmountInCompanyCodeCurrency) else 0 end as MARCH
} 
  where  
  (  a.FiscalYear = $parameters.ZFiscalYear  and a.CompanyCode = $parameters.ZCompanyCode 
    and a.Ledger = '0L' // and a.IsReversal <> 'X' and a.IsReversed <> 'X' 
    )
    group by
     a.CompanyCode,
     a.FiscalYear,
     a.GLAccount ,
     a.CompanyCodeCurrency,
     a.FiscalPeriod
 