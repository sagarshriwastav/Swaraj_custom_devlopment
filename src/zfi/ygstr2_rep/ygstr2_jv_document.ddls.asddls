@AbapCatalog.sqlViewName: 'YJVDOCUMENT'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 REPORT'
define view YGSTR2_JV_DOCUMENT 
as select  from I_OperationalAcctgDocItem as a  
   left outer join I_JournalEntry   as b on b.CompanyCode        = a.CompanyCode
                                        and b.FiscalYear         = a.FiscalYear
                                        and b.AccountingDocument = a.AccountingDocument    
                                  //      and ( A.FinancialAccountType = 'K'   ) 
                                    //     and  b.IsReversed = 'x'
   left outer join I_JournalEntry   as f on f.CompanyCode        = a.CompanyCode
                                        and f.FiscalYear         = a.FiscalYear
                                        and f.AccountingDocument = a.AccountingDocument    
                                        and ( f.IsReversed <> ' ' or f.IsReversal <> ' ' )
                                
   left outer join I_OperationalAcctgDocItem as C on  C.CompanyCode       = a.CompanyCode
                                                 and C.FiscalYear         = a.FiscalYear
                                                    and C.AccountingDocument = a.AccountingDocument    
                                                 and ( ( C.FinancialAccountType = 'D'  and C.SpecialGLCode <> 'A') or C.FinancialAccountType = 'K'   ) 
   left outer join I_Supplier            as    D on  D.Supplier = C.Supplier  
   left outer join I_Customer            as    G on  G.Customer = C.Customer
   left outer join YTAX_CODECDS           as   E on  E.Taxcode = a.TaxCode  

{
key a.AccountingDocument as FiDocument,
key a.FiscalYear as FiscalYear ,
    a.TaxItemAcctgDocItemRef as FiDocumentItem ,
    a.DocumentDate , 
    a.TransactionCurrency,
    a.CompanyCode,
    a.AssignmentReference as Refrence_No  ,
    a.AccountingDocumentType  ,
    a.PostingDate,
    C.BusinessPlace,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    a.AmountInCompanyCodeCurrency as  TaxableValue,
    @Semantics.amount.currencyCode: 'TransactionCurrency'   
   ( (  a.AmountInCompanyCodeCurrency ) + (a.TaxBaseAmountInTransCrcy) ) as InvoceValue ,
    (  a.TaxBaseAmountInTransCrcy  ) as Gross_amount,
    a.TaxCode ,  
    @Semantics.amount.currencyCode: 'TransactionCurrency'  
   case a.TransactionTypeDetermination
   when  'JII' then ( a.AmountInCompanyCodeCurrency ) end as igst,
   case a.TransactionTypeDetermination
   when  'JIC' then ( a.AmountInCompanyCodeCurrency ) end as cgst,
   case a.TransactionTypeDetermination
   when  'JIS' then ( a.AmountInCompanyCodeCurrency ) end as Sgst,
     a.GLAccount,
     a.DebitCreditCode,
   //  a.IsNegativePosting,
     b.AccountingDocumentHeaderText,
     b.DocumentReferenceID,
     case when  f.ReversalReferenceDocument is not null then 'X'
     else
     f.IsReversed end as  IsReversed,
   //  f.IsReversed,
     f.ReversalReferenceDocument,
     case C.Supplier when ' ' then
     ( C.Customer ) else ( C.Supplier ) end  as PARTYcODE,
   //  C.Customer as CUSTOMER, 
     a.IN_GSTPlaceOfSupply as PLACE_SUPPLY,
     case ( D.IN_GSTSupplierClassification ) when ' ' then 
          ( G.CustomerClassification ) else ( D.IN_GSTSupplierClassification ) end as  IN_GSTSupplierClassification,     
     case ( D.SupplierName ) when ' ' then 
          ( G.CustomerName ) else  ( D.SupplierName ) end    as PartyName,
     case ( D.TaxNumber3 ) when ' ' then 
          ( G.TaxNumber3 ) else  ( D.TaxNumber3 ) end  as  GstIn,
     case ( D.Region ) when ' ' then 
          ( G.Region ) else  ( D.Region ) end    as  State,                                                      
     E.gstrate as TaxRate,
     E.Taxcodedescription  
}
   where                 
                           
                (  a.AccountingDocumentType =  'AA'  or 
                   a.AccountingDocumentType =  'DZ' or
         //        a.AccountingDocumentType =  'KZ' or
                   a.AccountingDocumentType =  'AB' or
                   a.AccountingDocumentType =  'KA' or
                   a.AccountingDocumentType =  'KR' or
                   a.AccountingDocumentType =  'SA' )
                   
            and

            ( a.TransactionTypeDetermination = 'JII' or 
              a.TransactionTypeDetermination = 'JIC' or 
              a.TransactionTypeDetermination = 'JIS'  ) 
           
         
