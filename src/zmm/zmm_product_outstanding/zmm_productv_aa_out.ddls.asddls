@AbapCatalog.sqlViewName: 'ZMMVENOUTSTANDAA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@EndUserText.label: 'Product Wise Stock Asset'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view  ZMM_PRODUCTV_AA_OUT  as select from 
I_OperationalAcctgDocItem as a 
inner join I_OperationalAcctgDocItem as B on 
(a.CompanyCode = B.CompanyCode and a.FiscalYear = B.FiscalYear and a.AccountingDocument = B.AccountingDocument
  )
{
 key  a.CompanyCode,
 key  a.FiscalYear,
 key  a.AccountingDocument,    
      a.Supplier,
      a.Product,
      B.ProfitCenter,
      B.PurchasingDocument,
      B.PurchasingDocumentItem
    
} where a.FinancialAccountType = 'A' and B.FinancialAccountType = 'A'
