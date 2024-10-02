@AbapCatalog.sqlViewName: 'YTOTALDISBURSED'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Cds For Loan Moduel Report'
define view ZTotalDisbursed_CDS 
  with parameters 
                p_posting:abap.dats
  as select from I_OperationalAcctgDocItem
{   
    key GLAccount,
    key CompanyCode,
        TransactionCurrency,
    sum(AmountInCompanyCodeCurrency) as TotalDisbursed
} 
where  PostingDate <= $parameters.p_posting
  group by  
         CompanyCode,
         TransactionCurrency,
         GLAccount
