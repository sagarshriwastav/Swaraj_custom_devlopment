@AbapCatalog.sqlViewName: 'YVENDOR'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Wise Vendor Outstandimg Report'
define view ZMM_PRODUCT_OUTSTANDING1 with parameters 
                p_comp : abap.char( 4 ) ,
                p_posting:abap.dats,
                p_posting1:abap.dats
 as select from I_OperationalAcctgDocItem
 as a left outer join ZMM_PRODUCTV_OUTSTANDING as b 
 on (a.CompanyCode = b.CompanyCode and a.FiscalYear = b.FiscalYear and a.AccountingDocument = b.AccountingDocument)
 left outer join I_Product as c on (c.Product = b.Product )
 left outer join I_ProductDescription as G on (G.Product = b.Product and G.Language = 'E' )
 left outer join I_JournalEntry as d on ( d.CompanyCode = a.CompanyCode and d.FiscalYear = a.FiscalYear and d.AccountingDocument = a.AccountingDocument)
 left outer join I_Supplier  as e on  ( e.Supplier = a.Supplier )
 left outer join I_PurchaseOrderItemAPI01 as f on (f.PurchaseOrder = b.PurchasingDocument 
                                                   and f.PurchaseOrderItem = b.PurchasingDocumentItem)
  left outer join ZI_Operational_PROFITCENTER as I on ( I.CompanyCode = a.CompanyCode and I.FiscalYear = a.FiscalYear 
                                                     and I.AccountingDocument = a.AccountingDocument)                                                     
  left outer join YFI_PAYMENT_PROFITCENTER as h on ( h.CompanyCode = a.CompanyCode and h.FiscalYear = a.FiscalYear 
                                                     and h.AccountingDocument = a.AccountingDocument)  
                                                                                         
{
 key  a.CompanyCode,
 key  a.FiscalYear,
 key  a.AccountingDocument,
      a.AccountingDocumentType,
      a.Supplier,
      b.Product,
      case when I.ProfitCenter <> '' then I.ProfitCenter
      else h.ProfitCenter end as  ProfitCenter,
      a.PostingDate,
      a.NetDueDate,
      a.CompanyCodeCurrency,
      a.GLAccount,
      a.DueCalculationBaseDate,
   //   case a.AccountingDocumentType  
     // when 'KZ' then '18'
     // else
      c.Division  as division,
      d.DocumentReferenceID,
      d.AccountingDocumentHeaderText,
      e.SupplierName,
      f.PurchaseOrder,
      f.PurchaseOrderItem,
      f.MaterialGroup,
      f.AccountAssignmentCategory,
      f.PurchaseOrderItemCategory,
      f.BaseUnit,
      G.ProductDescription,
      f.ProductType,
      case 
      when  b.Product   like 'Y%'    or  d.AccountingDocumentHeaderText = 'YARN PURCHASE'       then 'SUNDRY CREDITORS FOR YARN'
      
      when  b.Product   like 'FFP%'  or  d.AccountingDocumentHeaderText = 'FINISH FABRIC'       then 'SUNDRY CREDITORS FOR FABRICS'
      
      when  b.Product   like 'ETP%'  or  d.AccountingDocumentHeaderText = 'AGRO WASTE HUSK'     then 'SUNDRY CREDITORS FOR AGRO WASTE HUSK' 
      
      when  b.Product   like 'SC%'   or  d.AccountingDocumentHeaderText = 'BUILDING ITEM'       then  'SUNDRY CREDITORS FOR BUILDING'  
      
      when ( b.Product   is initial   and f.AccountAssignmentCategory  like 'A' ) or  d.AccountingDocumentHeaderText = 'CAPITAL GOODS'
      then 'SUNDRY CREDITORS FOR CAPITAL GOODS' 
      
      when  b.Product  like 'SD%'    or  d.AccountingDocumentHeaderText = 'CHEMICALS AND DYES'   then  'SUNDRY CREDITORS FOR CHEMICALS AND DYES'
    
      when  b.Product  like 'FGP%'   or  d.AccountingDocumentHeaderText = 'GREY FABRIC'          then  'SUNDRY CREDITORS FOR GREY'
      
      when  b.Product  like 'FF%'    and f.AccountAssignmentCategory  like '3'  
                                     or  d.AccountingDocumentHeaderText = 'PROCESSING'           then  'SUNDRY CREDITORS FOR PROCESSING'  
                                     
      when  b.Product  like 'FG%'    and f.AccountAssignmentCategory  like '3'  
                                     or  d.AccountingDocumentHeaderText = 'JOB WORK'             then  'SUNDRY CREDITORS FOR JOB' 
                                     
      when  a.GLAccount = '2500003000'                                                           then  'SUNDRY CREDITORS FOR IMPORT'   
      
      when  b.Product  like 'S%'     and b.Product not like 'SD%' and b.Product not like 'SC%'
                                    or  d.AccountingDocumentHeaderText = 'STORES ITEM'           then 'SUNDRY CREDITORS FOR STORES'   
      else
     'SUNDRY CREDITORS FOR OTHER' end as TYPE,   
  @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
     sum( a.AmountInCompanyCodeCurrency )  as Amount 
    
    
} where ( a.CompanyCode = $parameters.p_comp 
  
   and a.PostingDate between $parameters.p_posting
   and $parameters.p_posting1 ) and a.FinancialAccountType = 'K' 
   and a.ClearingAccountingDocument = '' and a.SpecialGLCode <> 'F'
 group by a.CompanyCode,
          a.FiscalYear,
          a.AccountingDocument,
          a.Supplier,
          b.Product,
          h.ProfitCenter,
          I.ProfitCenter,
          a.PostingDate,
          a.NetDueDate,
          a.CompanyCodeCurrency,
          a.DueCalculationBaseDate,
          a.GLAccount,
          c.Division,
          d.DocumentReferenceID,
          d.AccountingDocumentHeaderText,
          e.SupplierName,
          a.AccountingDocumentType,
          f.PurchaseOrder,
          f.PurchaseOrderItem,
          f.MaterialGroup,
          f.BaseUnit,
          f.AccountAssignmentCategory,
          f.PurchaseOrderItemCategory,
          G.ProductDescription,
          f.ProductType
      
