@AbapCatalog.sqlViewName: 'YPAYMENT3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Payment Advice Report'
define view YFI_PAYMENT_CDS_3 as select from YFI_PAYMENT_CDS as a
 left outer join I_OperationalAcctgDocItem as h on ( h.AccountingDocument = a.AccountingDocument and h.CompanyCode = a.CompanyCode 
                         and h.FiscalYear = a.FiscalYear and h.DebitCreditCode <> 'H' and a.PartyName is null )
 left outer join I_GLAccountText as g on  ( g.GLAccount = h.GLAccount and g.Language = 'E' )
 
{
    key a.AccountingDocument,
    key a.FiscalYear,
    key a.CompanyCode,
    a.PartyCode,
    case when a.PartyName <> '' then a.PartyName else
    g.GLAccountName end as PartyName,
    a.Supplier,
    a.SpecialGLCode,
    a.DocumentItemText,
    a.TransactionCurrency,
    a.AccountingDocumentType,
    a.PostingDate,
    a.HouseBank,
    a.TRANCATIONAMOUNT,
    a.PaymentTransferred,
    a.PaymentReceived
}
