@AbapCatalog.sqlViewName: 'ZGSTR2'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GSTR2 REPORT'
define view YGSTR2
  as select from    I_OperationalAcctgDocItem as a
    inner join      I_OperationalAcctgDocItem as b on(
                                          b.AccountingDocument = a.AccountingDocument
                                      and b.FinancialAccountType = 'K'  and b.FiscalYear = a.FiscalYear 
//                                      and b.AccountingDocumentItemType = 'W'
                                      and b.CompanyCode = a.CompanyCode )
    left outer join I_Supplier            as    C on ( b.Supplier = C.Supplier )
    left outer join YTAX_CODECDS          as    D on ( a.TaxCode = D.Taxcode )
    left outer join I_JournalEntry        as    E on ( a.AccountingDocument = E.AccountingDocument  and a.FiscalYear = E.FiscalYear
                                                      and a.CompanyCode = E.CompanyCode )
    left outer join I_JournalEntry        as    F on ( a.AccountingDocument = F.AccountingDocument  and a.FiscalYear = F.FiscalYear 
                                                     and a.CompanyCode = F.CompanyCode )  and ( F.IsReversed <> ' ' or F.IsReversal <> ' ')

{
  key a.AccountingDocument                                    as FiDocument,
  key a.FiscalYear                                             as FiscalYear,
  key a.CompanyCode,
      a.TaxItemAcctgDocItemRef                                  as FiDocumentItem,
      a.AccountingDocumentItem, 
      a.DocumentDate,
      b.BusinessPlace,
      a.Quantity,
      a.BaseUnit,
      a.TransactionCurrency,
      left(  a.OriginalReferenceDocument  , 10 )              as Mironumber,
      right( a.OriginalReferenceDocument  , 4 )               as MiroYear,
      b.AssignmentReference                                   as Refrence_No,
      a.AccountingDocumentType,
      a.PostingDate,
      a.TransactionTypeDetermination,
      a.IN_HSNOrSACCode                                       as HsnCode,
      b.AssignmentReference ,
      
     
    //  a.TaxBaseAmountInCoCodeCrcy                             as InvoceValue,
     
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case a.TransactionTypeDetermination
       when  'JRI' then ( a.TaxBaseAmountInCoCodeCrcy * 0  )
      when  'JRC' then ( a.TaxBaseAmountInCoCodeCrcy * 0  )
      when  'JRS' then ( a.TaxBaseAmountInCoCodeCrcy * 0 )
      else
      ( a.TaxBaseAmountInCoCodeCrcy ) end                  as InvoceValue,
      
 @Semantics.amount.currencyCode: 'TransactionCurrency'
      case a.TransactionTypeDetermination
      when  'JIC' then ( a.AmountInCompanyCodeCurrency * 2 )
      when  'JIS' then ( a.AmountInCompanyCodeCurrency * 2 )
      when  'JRC' then ( a.AmountInCompanyCodeCurrency * 2 )
      when  'JRS' then ( a.AmountInCompanyCodeCurrency * 2 )
      else
      ( b.AmountInCompanyCodeCurrency  ) end                  as TaxableValue,
 @Semantics.amount.currencyCode: 'TransactionCurrency'
             case a.TransactionTypeDetermination
          when  'JII' then (  ( a.TaxBaseAmountInCoCodeCrcy  ) + ( a.AmountInCompanyCodeCurrency  )  )
          when  'JIC' then (  ( a.TaxBaseAmountInCoCodeCrcy  ) + ( a.AmountInCompanyCodeCurrency * 2 )  )
          when  'JIS' then (  ( a.TaxBaseAmountInCoCodeCrcy  ) + ( a.AmountInCompanyCodeCurrency * 2 )  )          
          when  'JRC' then (  ( a.TaxBaseAmountInCoCodeCrcy * 0 ) + ( a.AmountInCompanyCodeCurrency * 2 )  )         
          when  'JRS' then (  ( a.TaxBaseAmountInCoCodeCrcy *  0 ) + ( a.AmountInCompanyCodeCurrency * 2 )  )
           else
         (  a.AmountInCompanyCodeCurrency ) end  as Gross_amount ,
      //  a.AmountInCompanyCodeCurrency as TaxableValue ,
      //   ( a.TaxBaseAmountInCoCodeCrcy + a.AmountInCompanyCodeCurrency ) as Gross_amount,
      a.TaxCode,
      a.DebitCreditCode,
      a.IsNegativePosting,
      @Semantics.amount.currencyCode: 'TransactionCurrency'
      case a.TransactionTypeDetermination
       when  'JII' then ( a.AmountInCompanyCodeCurrency ) end as igst,
      case a.TransactionTypeDetermination
      when  'JIC' then ( a.AmountInCompanyCodeCurrency ) end  as cgst,
      case a.TransactionTypeDetermination
      when  'JIS' then ( a.AmountInCompanyCodeCurrency ) end  as Sgst,
      case a.TransactionTypeDetermination
      when  'JRI' then ( a.AmountInCompanyCodeCurrency ) end  as RCM_igst,
      case a.TransactionTypeDetermination
      when  'JRC' then ( a.AmountInCompanyCodeCurrency ) end  as RCM_cgst,
      case a.TransactionTypeDetermination
      when  'JRS' then ( a.AmountInCompanyCodeCurrency ) end  as RCM_Sgst,
      b.Supplier                                              as PARTYcODE,
      b.IN_GSTPlaceOfSupply                                   as PlaceofSupply,
      b.FinancialAccountType,
      C.IN_GSTSupplierClassification,
      C.SupplierName                                          as PartyName,
      C.SupplierFullName                                      as PartyAdd,
      C.TaxNumber3                                            as GstIn,
      C.Region                                                as State,
      
      D.gstrate as TaxRate,
      D.Taxcodedescription,
      E.AccountingDocumentHeaderText,
      E.DocumentReferenceID,
       a.GLAccount,
     case when  F.ReversalReferenceDocument is not null then 'X'
     else
     F.IsReversed end as  IsReversed,
   //   F.IsReversed,
      F.ReversalReferenceDocument

      
   //   case a.TransactionTypeDetermination
   //   when  'JIC' then ( D.gstrate * 2 )
   //   when  'JIS' then ( D.gstrate * 2 )
  //    when  'JRC' then ( D.gstrate * 2 )
  //    when  'JRS' then ( D.gstrate * 2 )
  //    else
 //     ( D.gstrate  ) end      as TaxRate


}
where
  a.AccountingDocumentItemType = 'T' and a.TransactionTypeDetermination <> 'JIM'
