@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Payment Advice Report'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity YFI_PAYMENT_CDS2 as select from YFI_PAYMENT_CDS as a 
         left outer join I_HouseBankAccountLinkage as c on ( c.HouseBank = a.HouseBank and c.CompanyCode = a.CompanyCode and c.BankAccount != ' ' )
         left outer join YFI_PAYMENT_PROFITCENTER as g on ( g.AccountingDocument = a.AccountingDocument 
                                                         and g.CompanyCode = a.CompanyCode 
                                                         and g.FiscalYear = a.FiscalYear )
                                                  
                                                  
    
             

{
    key a.AccountingDocument,
    key a.FiscalYear,
    key a.CompanyCode,
        a.PartyCode,
        a.PartyName,
        a.SpecialGLCode,
        a.DocumentItemText,
        a.TransactionCurrency,
        a.PostingDate,
        a.AccountingDocumentType,
        a.HouseBank,
        c.BankName,
        c.BankAccount  as BankACCNumber,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        sum(a.PaymentTransferred) as PaymentTransferred,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        sum(a.PaymentReceived) as  PaymentReceived,
        g.ProfitCenter   
        
} 
group by 
    a.AccountingDocument,
    a.FiscalYear,
    a.CompanyCode,
    a.PartyCode,
    a.PartyName,
    a.SpecialGLCode,
    a.DocumentItemText,
    a.PostingDate, 
    a.HouseBank,
    a.TransactionCurrency,
    a.AccountingDocumentType,
    c.BankAccount,
    c.BankName,
    g.ProfitCenter

