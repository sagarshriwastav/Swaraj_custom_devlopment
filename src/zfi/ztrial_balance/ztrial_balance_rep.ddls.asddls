@AbapCatalog.sqlViewName: 'YREPTRIAL'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Trial Balance Report'
define view ZTRIAL_BALANCE_REP 
 with parameters
    ZCompanyCode : abap.char( 4 ),
    ZFiscalYear   : abap.char( 4 ) 
 as select from ZTRIAL_BALANCE_CDS1( ZCompanyCode: $parameters.ZCompanyCode , ZFiscalYear: $parameters.ZFiscalYear ) as MASTER
left outer join ZTRIAL_BALANCE_CDS( ZCompanyCode: $parameters.ZCompanyCode , ZFiscalYear: $parameters.ZFiscalYear ) as OPENING 
                                   on ( OPENING.CompanyCode = MASTER.CompanyCode and OPENING.GLAccount = MASTER.GLAccount 
                                    and OPENING.CompanyCodeCurrency = MASTER.CompanyCodeCurrency )
left outer join ZTRIAL_BALANCE_MID1( ZCompanyCode: $parameters.ZCompanyCode , ZFiscalYear: $parameters.ZFiscalYear ) as MID  
                                   on ( MID.CompanyCode = MASTER.CompanyCode and MID.GLAccount = MASTER.GLAccount 
                            //       and MID.FiscalYear = MASTER.FiscalYear
                                   and MID.CompanyCodeCurrency = MASTER.CompanyCodeCurrency  )   
 left outer join I_GLAccountText as D on ( D.GLAccount = MASTER.GLAccount and D.Language = 'E' )                              
{
    key  MASTER.CompanyCode,
    key  '' as FiscalYear,
    key  MASTER.GLAccount,
    MASTER.CompanyCodeCurrency,
//    @Semantics.amount.currencyCode: 'TransactionCurrency'
    OPENING.OpeningAmount,
//    @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.APRIL,
//    @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.MAY,
//    @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.JUNE,
 //   @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.JULY,
 //   @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.AUGUST,
 //   @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.SEPTEMBER,
 //   @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.OCTOBER,
 //   @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.NOVEMBER,
 //   @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.DECEMBER,
 //   @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.JANUARY,
 //   @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.FEBRUARY,
//    @Semantics.amount.currencyCode: 'TransactionCurrency'
    MID.MARCH,
    D.GLAccountLongName
    
} 
//where
// ( MASTER.FiscalYear  <= $parameters.ZFiscalYear and MASTER.CompanyCode = $parameters.ZCompanyCode  )
