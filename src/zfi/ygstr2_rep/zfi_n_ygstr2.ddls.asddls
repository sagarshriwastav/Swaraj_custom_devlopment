@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'YGSTR2_REPORT'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZFI_N_YGSTR2 as select from YGSTR2_1 as a

  
{
    key a.FiDocument,
    key a.FiscalYear,
    key a.CompanyCode,
    '' as FiDocumentItem,
    a.DocumentDate,
    a.TransactionCurrency  ,   
    a.Mironumber,
    a.MiroYear,
    a.Refrence_No,
    a.AccountingDocumentType,
    a.PostingDate,
    a.HsnCode,
    a.AssignmentReference,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.InvoceValue  ) as InvoceValue,
//    a.InvoceValue    as InvoceValue,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.TaxableValue  ) as TaxableValue,
//    a.TaxableValue   as TaxableValue,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.Gross_amount ) as Gross_amount,
//    a.Gross_amount  as Gross_amount,
    a.TaxCode,   
    @Semantics.amount.currencyCode: 'TransactionCurrency' 
    sum( a.IGST )                     as IGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum( a.CGST )                     as CGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum( a.SGST )                     as SGST,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum( a.RCMI )                 as RCMI,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.RCMC)                   as RCMC,
    @Semantics.amount.currencyCode: 'TransactionCurrency'
    sum(a.RCMS)                   as RCMS,
    a.PARTYcODE,
    a.PlaceofSupply,
    a.FinancialAccountType,
    a.IN_GSTSupplierClassification,
    a.PartyName,
    a.GstIn,
    a.State,
    a.TaxRate,
    a.Taxcodedescription,
    a.AccountingDocumentHeaderText,
    a.DocumentReferenceID,
    a.IsReversed,
    a.BusinessPlace,
    a.ReversalReferenceDocument,
    @Semantics: { quantity : {unitOfMeasure: 'BaseUnit'} }
    a.Quantity,
    a.BaseUnit,
    a.PartyAdd
    
    
}    where  a.AccountingDocumentType = 'RE' or 
            a.AccountingDocumentType = 'ZA' or
            a.AccountingDocumentType = 'RK' or
            a.AccountingDocumentType = 'KC' or
            a.AccountingDocumentType = 'KG' or 
            ( ( a.TaxCode = 'R1' or  a.TaxCode = 'R2' or  a.TaxCode = 'R3' or  
                a.TaxCode = 'R4' or  a.TaxCode = 'R5' or  a.TaxCode = 'R6' or 
                a.TaxCode = 'R7' or  a.TaxCode = 'R8' ) and  a.FinancialAccountType <> 'D' )



   group by
  
    a.FiDocument,
    a.FiscalYear,
    a.CompanyCode,
  //  a.FiDocumentItem,
    a.DocumentDate,
    a.TransactionCurrency,
    a.Mironumber,
    a.MiroYear,
    a.Refrence_No,
    a.AccountingDocumentType,
    a.PostingDate,
    a.HsnCode,
    a.AssignmentReference,
//    a.InvoceValue,
//    a.TaxableValue,
//    a.Gross_amount,
    a.TaxCode,
    a.PARTYcODE,
    a.PlaceofSupply,
    a.FinancialAccountType,
    a.IN_GSTSupplierClassification,   
    a.PartyName,
    a.GstIn,
    a.State,
    a.TaxRate,
    a.Taxcodedescription,
    a.AccountingDocumentHeaderText,
    a.DocumentReferenceID,
    a.IsReversed,
    a.BusinessPlace,
    a.ReversalReferenceDocument,
    
    a.Quantity,
    a.BaseUnit,
    a.PartyAdd
    
    
