@AbapCatalog.sqlViewName: 'YSUMSUPPLIER4'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Customer Outstanding Report'
define view ZFI_CUSTOMER_WISE_AMT4 with parameters 
                p_comp : abap.char( 4 ) ,
                p_posting:abap.dats,
                p_posting1:abap.dats,
                RAMT:abap.int4,
                RAMT1:abap.int4, 
                RAMT2:abap.int4,
                RAMT3:abap.int4
as select from ZFI_CUSTOMER_WISE_AMT3( p_comp : $parameters.p_comp, p_posting : $parameters.p_posting, 
                                      p_posting1 : $parameters.p_posting1 , RAMT : $parameters.RAMT ,
                                      RAMT1 : $parameters.RAMT1 ,RAMT2 : $parameters.RAMT2 ,
                                      RAMT3 : $parameters.RAMT3 
                                       )
{
    key CompanyCode,
    key FiscalYear,
    key Customer,
    CustomerName,
    CompanyCodeCurrency,
    TYPE,
    ProfitCenter,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(Amount)   as Amount,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(AMT030)   as AMT030,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(AMT060)   as AMT060,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(AMT090)   as AMT090,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(AMT120)   as AMT120,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum(AMT121)   as AMT121
}
   group by 
      CompanyCode,
      FiscalYear,
      Customer,
      CustomerName,
      TYPE,
      ProfitCenter,
      CompanyCodeCurrency
