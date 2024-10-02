@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'AMOUNT SUM'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_OperationalAMOUNT_SUM as select from  I_OperationalAcctgDocItem as A
//left outer join I_Supplier as D on (   D.Supplier = A.Supplier    ) 

{ key   A.CompanyCode,
  key    A.FiscalYear,
  key    A.AccountingDocument,
       A.PostingDate,
      A.ClearingItem,
      A.CompanyCodeCurrency,
      A.ProfitCenter,
      @Semantics: { amount : {currencyCode: 'CompanyCodeCurrency'} }
      sum(A.AmountInCompanyCodeCurrency ) as  AmountInCompanyCodeCurrency
      
}   where A.FinancialAccountType = 'K'

  group by  A.CompanyCode,
       A.FiscalYear,
       A.AccountingDocument,
      A.PostingDate,
      A.CompanyCodeCurrency,
       A.ClearingItem,
         A.ProfitCenter
     // A.AmountInCompanyCodeCurrency
