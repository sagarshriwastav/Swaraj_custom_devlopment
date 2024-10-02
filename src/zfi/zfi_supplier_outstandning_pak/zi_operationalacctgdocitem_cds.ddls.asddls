@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_OperationalAcctgDocItem_CDS'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_OperationalAcctgDocItem_CDS as select from I_OperationalAcctgDocItem  as A

{ 
  key A.CompanyCode,
  key A.FiscalYear, 
  key A.AccountingDocument,
  key    A.ProfitCenter,
  key A.Plant,
     A.PurchasingDocument
    
} where    A.FinancialAccountType = 'S' and   A.AccountingDocumentItemType <> 'T'  
  

  group by 
   A.CompanyCode,
   A.FiscalYear, 
   A.AccountingDocument,
      A.ProfitCenter,
   A.Plant,
     A.PurchasingDocument
