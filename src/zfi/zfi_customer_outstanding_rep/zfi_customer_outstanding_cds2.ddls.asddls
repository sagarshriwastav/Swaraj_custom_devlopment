@AbapCatalog.sqlViewName: 'ZFICUSTOMER'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For  Customer Outstanding Report'
define view  ZFI_CUSTOMER_OUTSTANDING_CDS2 
      with parameters 
                p_comp : abap.char( 4 ) ,
                p_posting:abap.dats,
                p_posting1:abap.dats
 as select from I_OperationalAcctgDocItem
 as a  left outer join ZFI_CUSTOMER_OUTSTANDING_CDS1 as b 
 on (a.CompanyCode = b.CompanyCode and a.FiscalYear = b.FiscalYear and a.AccountingDocument = b.AccountingDocument)
 left outer join I_Product as c on (c.Product = b.Product )
 left outer join I_ProductDescription as G on (G.Product = b.Product and G.Language = 'E' )
 left outer join I_JournalEntry as d on ( d.CompanyCode = a.CompanyCode and d.FiscalYear = a.FiscalYear and d.AccountingDocument = a.AccountingDocument)
 left outer join I_Customer  as e on  ( e.Customer = a.Customer )
 left outer join I_Supplier  as I on ( I.Supplier = a.Supplier)
 left outer join I_SalesDocumentItem as f on (f.SalesDocument = b.SalesDocument 
                                                   and f.SalesDocumentItem = b.SalesDocumentItem) 
 
 left outer join ZI_Operational_PROFITCENTER as J on ( J.CompanyCode = a.CompanyCode and J.FiscalYear = a.FiscalYear 
                                                     and J.AccountingDocument = a.AccountingDocument)  
                                                                                                       
  left outer join YFI_PAYMENT_PROFITCENTER as h on ( h.CompanyCode = a.CompanyCode and h.FiscalYear = a.FiscalYear and h.AccountingDocument = a.AccountingDocument)                                                  
{
 key  a.CompanyCode,
 key  a.FiscalYear,
 key  a.AccountingDocument,
      a.AccountingDocumentType,
      a.Customer,
      b.Product,
      a.PostingDate,
      a.NetDueDate,
      a.GLAccount,
      a.OriginalReferenceDocument,
   //   case a.AccountingDocumentType  
     // when 'KZ' then '18'
     // else
      c.Division  as division,
      d.DocumentReferenceID,
      d.AccountingDocumentHeaderText,
       case when J.ProfitCenter <> '' then J.ProfitCenter
      else h.ProfitCenter end as  ProfitCenter,
      e.CustomerName,
      f.SalesDocument,
      f.SalesDocumentItem,
      f.MaterialGroup,
  //    f.AccountAssignmentCategory,
  //    f.PurchaseOrderItemCategory,
      G.ProductDescription, 
      a.CompanyCodeCurrency,
      a.DueCalculationBaseDate,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum( a.AmountInCompanyCodeCurrency ) as Amount,
    
      case 
      when  b.Product   like 'Y%'   or  d.AccountingDocumentHeaderText = 'YARN PURCHASE'     then 'SUNDRY DEBTORS FOR YARN SALE'
      when  b.Product   like 'FGO%' or  d.AccountingDocumentHeaderText = 'GREY FABRIC'      then 'SUNDRY DEBTORS FOR  GREY SALE'
      when  b.Product   like 'FFO%'  or  d.AccountingDocumentHeaderText = 'FINISH FABRIC'   then 'SUNDRY DEBTORS FOR FABRIC SALE' 
      when  b.Product   like 'WW%'    or  d.AccountingDocumentHeaderText = 'AGRO WASTE HUSK'  then  'SUNDRY DEBTORS FOR WASTAGE SALE'  
      when ( b.Product   like 'FGJ%' or b.Product   like 'FFJ%' or  d.AccountingDocumentHeaderText = 'JOB WORK'  )
      then 'SUNDRY DEBTORS FOR JOB SALE' 
   //   when  b.Product  like '%'   then  'SUNDRY DEBTORS FOR EXPORT SALE'
      else 'SUNDRY DEBTORS FOR OTHER' end 
      as TYPE


} where ( a.CompanyCode = $parameters.p_comp 
//or ProfitCenter = $parameters.p_profit
 //or Supplier = $parameters.p_ven  or
 and a.PostingDate between $parameters.p_posting
   and $parameters.p_posting1 ) and a.FinancialAccountType = 'D'  and a.ClearingAccountingDocument = ''  
   and a.SpecialGLCode <> 'F' 
     
 group by a.CompanyCode,
          a.FiscalYear,
          a.AccountingDocument,
          a.Customer,
          a.OriginalReferenceDocument,
          b.Product,
          h.ProfitCenter,
          J.ProfitCenter,
          a.PostingDate,
          a.NetDueDate,
          a.CompanyCodeCurrency,
          a.GLAccount,
          c.Division,
          d.DocumentReferenceID,
          d.AccountingDocumentHeaderText,
          e.CustomerName,
          a.DueCalculationBaseDate,
          a.AccountingDocumentType,
          f.SalesDocument,
         f.SalesDocumentItem,
          f.MaterialGroup,
         // f.AccountAssignmentCategory,
         // f.PurchaseOrderItemCategory,
          G.ProductDescription
        //  f.ProductType
         
