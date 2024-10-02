@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ymseg3'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZTRIAL_BALANCE_CDS 
with parameters 
    ZCompanyCode : abap.char( 4 ),
    ZFiscalYear   : abap.char( 4 )
   as select from  I_GLAccountLineItem as a
{
   key a.CompanyCode,
   key a.GLAccount ,
       a.CompanyCodeCurrency,
       sum(cast(a.AmountInCompanyCodeCurrency as abap.dec( 13, 3 ) ) ) as OpeningAmount
} 
  where  
  ( FiscalYear < $parameters.ZFiscalYear  and CompanyCode = $parameters.ZCompanyCode 
  and a.Ledger = '0L' ) // and a.IsReversal <> 'X' and a.IsReversed <> 'X' )
    group by
     a.CompanyCode,
     a.CompanyCodeCurrency,
     a.GLAccount 
