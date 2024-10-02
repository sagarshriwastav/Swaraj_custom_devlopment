@AbapCatalog.sqlViewName: 'YOBLIREP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For EPCG Obligation Report'
define view ZEPCG_OBLIGATION_REP_CDS as select from zepcg_obligation as a 
left outer join ZEPCG_OBLIGATION_CDS1 as b on ( b.epcgno = a.epcg_license_no )
{
    key a.epcg_license_no,
    key a.valid_from,
    key a.valid_to,
        a.export_obligation,
        b.TransactionCurrency,
        b.invoicevalue,
        ( a.export_obligation - b.invoicevalue ) as BalanceValue
       
}
