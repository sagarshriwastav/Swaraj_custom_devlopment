@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ymseg3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTRIAL_BALANCE_CDS1 
with parameters 
    ZCompanyCode : abap.char( 4 ),
    ZFiscalYear   : abap.char( 4 ) 
    as select from I_GLAccountLineItem
{
    key CompanyCode, 
    key FiscalYear,
    key GLAccount,
    key CompanyCodeCurrency
} 
where  
   Ledger = '0L' //and IsReversal <> 'X' and IsReversed <> 'X' 
   and ( FiscalYear  <= $parameters.ZFiscalYear and CompanyCode = $parameters.ZCompanyCode  )
  group by 
    CompanyCode,
    FiscalYear,
    GLAccount,
    CompanyCodeCurrency
