@AbapCatalog.sqlViewName: 'ZEPCGCDS3'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For EPCG Obligation Report'
define view ZEPCG_OBLIGATION_HEAD_CDS1  as select from ZEPCG_OBLIGATION_CDS as a
left outer join I_BillingDocumentItem as b on ( b.BillingDocument = a.docno )
{
    key a.epcgno,
    key a.docno,
        b.TransactionCurrency,
        sum(b.NetAmount ) as invoicevalue
} 
  group by 
       a.epcgno,
       a.docno,
       b.TransactionCurrency
