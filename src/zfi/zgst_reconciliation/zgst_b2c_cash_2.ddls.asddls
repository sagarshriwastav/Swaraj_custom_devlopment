@EndUserText.label: 'B2C Cash Discount Report 2'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity zgst_b2c_cash_2 as 
select from zgst_b2c_cash as A
         left outer join  I_OperationalAcctgDocItem as B on ( A.AccountingDocument = B.AccountingDocument )
                                                         and ( A.CompanyCode = B.CompanyCode )
                                                         and ( A.FiscalYear = B.FiscalYear )
                                                         and B.TaxCode = 'V0'
         left outer join  I_OperationalAcctgDocItem as C on ( A.AccountingDocument = C.AccountingDocument )
                                                         and ( A.CompanyCode       = C.CompanyCode )
                                                         and ( A.FiscalYear        = C.FiscalYear )
                                                         and ( C.TaxCode  = 'Z1'
                                                          or   C.TaxCode  = 'Z2' 
                                                          or   C.TaxCode  = 'Z3' 
                                                          or   C.TaxCode  = 'Z4' 
                                                          or   C.TaxCode  = 'ZA' 
                                                          or   C.TaxCode  = 'ZB' 
                                                          or   C.TaxCode  = 'ZC' 
                                                          or   C.TaxCode  = 'ZD' 
                                                          )                                             
                                                         
{
    A.AccountingDocument,
    A.CompanyCode,
    A.FiscalYear,
    A.Supplier,
    A.AccountingDocumentType,
    A.SupplierName,
    A.TaxNumber3,
    A.DocumentReferenceID ,
    B.CompanyCodeCurrency ,
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    sum( B.AmountInCompanyCodeCurrency  ) as V0_AMOUNT ,
        @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    case 
    when  C.TaxCode  = 'Z1' 
       or C.TaxCode  = 'Z2' 
       or C.TaxCode  = 'Z3' 
       or C.TaxCode  = 'Z4' 
    then  C.OriginalTaxBaseAmount  end as BASEAMT ,    
    @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    case 
    when  C.TaxCode  = 'Z1' 
       or C.TaxCode  = 'Z2' 
       or C.TaxCode  = 'Z3' 
       or C.TaxCode  = 'Z4' 
    then  C.AmountInCompanyCodeCurrency  end as CGST_GROSSAMT ,
     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    case 
    when  C.TaxCode  = 'Z1' 
       or C.TaxCode  = 'Z2' 
       or C.TaxCode  = 'Z3' 
       or C.TaxCode  = 'Z4' 
    then ( C.AmountInCompanyCodeCurrency  - C.OriginalTaxBaseAmount ) end as CGST_AMT ,

     @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    case 
    when  C.TaxCode  = 'ZA' 
       or C.TaxCode  = 'ZB' 
       or C.TaxCode  = 'ZC' 
       or C.TaxCode  = 'ZD' 
    then ( C.AmountInCompanyCodeCurrency  ) end as IGST_GROSS ,
   @Semantics.amount.currencyCode: 'CompanyCodeCurrency'
    case 
    when  C.TaxCode  = 'ZA' 
       or C.TaxCode  = 'ZB' 
       or C.TaxCode  = 'ZC' 
       or C.TaxCode  = 'ZD' 
    then ( C.AmountInCompanyCodeCurrency -  C.OriginalTaxBaseAmount   ) end as IGST_AMT 
    
    
    
    
       
       
// or   C.TaxCode  = 'ZA' 
// or   C.TaxCode  = 'ZB' 
// or   C.TaxCode  = 'ZC' 
// or   C.TaxCode  = 'ZD' 








    
    
}

group by  A.AccountingDocument,
          A.CompanyCode,
          A.FiscalYear,
          A.Supplier,
          A.AccountingDocumentType,
          A.SupplierName,
          A.TaxNumber3,
          A.DocumentReferenceID,
          B.CompanyCodeCurrency ,
          C.TaxCode ,
          C.OriginalTaxBaseAmount ,
          C.AmountInCompanyCodeCurrency
          
