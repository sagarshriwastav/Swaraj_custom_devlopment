@AbapCatalog.sqlViewName: 'YEPCGOBLI'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For EPCG Obligation Report'
define view ZEPCG_OBLIGATION_CDS1 as select from ZEPCG_OBLIGATION_CDS as a
left outer join I_BillingDocumentItem as b on ( b.BillingDocument = a.docno )
{
    key a.epcgno,
        b.TransactionCurrency,
        sum(b.NetAmount ) as invoicevalue
} 
  group by 
       a.epcgno,
       b.TransactionCurrency
