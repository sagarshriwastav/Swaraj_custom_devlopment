@AbapCatalog.sqlViewName: 'ZMMVENOUTSTANDV'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@EndUserText.label: 'Product Wise Vendor Outstanding Report'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view  ZMM_PRODUCTV_OUTSTANDING as select from 
I_OperationalAcctgDocItem
{
 key  CompanyCode,
 key  FiscalYear,
 key  AccountingDocument,    
      Supplier,
      Product,
      ProfitCenter,
      PurchasingDocument,
      PurchasingDocumentItem
} where ( AccountingDocumentType = 'RE' or AccountingDocumentType = 'KR' or AccountingDocumentType = 'AA'
         or AccountingDocumentType = 'KG' or AccountingDocumentType = 'K6' or AccountingDocumentType = 'SA'  
           or AccountingDocumentType = 'UE'  or AccountingDocumentType = 'KC'
            or AccountingDocumentType = 'KZ'  or AccountingDocumentType = 'KA'
             or AccountingDocumentType = 'ZA' )
   and ( AccountingDocumentItemType = 'W' or Material <> '' or FinancialAccountType = 'A'
       or FinancialAccountType = 'L')
  
  group by 
      CompanyCode,
      FiscalYear,
      AccountingDocument,    
      Supplier,
      Product,
      ProfitCenter,
      PurchasingDocument,
      PurchasingDocumentItem
