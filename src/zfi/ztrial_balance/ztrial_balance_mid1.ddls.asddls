@AbapCatalog.sqlViewName: 'YTRAILMIDSUM'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Trial Balance Report'
define view ZTRIAL_BALANCE_MID1 
 with parameters
 ZCompanyCode : abap.char( 4 ),
    ZFiscalYear   : abap.char( 4 )
 as select from ZTRIAL_BALANCE_MID_GS( ZCompanyCode : $parameters.ZCompanyCode , ZFiscalYear : $parameters.ZFiscalYear )

{
    key CompanyCode,
    key FiscalYear,
    key GLAccount,
    key CompanyCodeCurrency,
    sum(APRIL) as APRIL,
    sum(MAY) as MAY,
    sum(JUNE) as JUNE,
    sum(JULY) as JULY,
    sum(AUGUST) as AUGUST,
    sum(SEPTEMBER) as SEPTEMBER,
    sum(OCTOBER) as OCTOBER,
    sum( NOVEMBER) as NOVEMBER,
    sum(DECEMBER) as DECEMBER,
    sum(JANUARY) as JANUARY,
    sum(FEBRUARY) as FEBRUARY,
    sum(MARCH) as MARCH
}
 group by 
  CompanyCode,
  FiscalYear,
  CompanyCodeCurrency,
  GLAccount
